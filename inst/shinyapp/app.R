# color_system.R
# 三维配色可视化系统 - 专业版

library(shiny)
library(bslib)
library(ggplot2)
library(shinyWidgets)
library(DT)
library(ggstyle)

# ========== 全局配置 ==========
# color_schemes <- list(
#   "Ocean" = c("#1A535C","#4ECDC4","#F7FFF7","#FF6B6B","#FFE66D"),
#   "Sunset" = c("#F3D7CA","#E6A4B4","#C86B85","#6C5B7B","#355C7D"),
#   "Forest" = c("#2C5F2D","#97BC62","#F4B942","#D6622D","#703B2F"),
#   "Neon" = c("#FF006E","#FFBE0B","#8338EC","#3A86FF","#FB5607"),
#   "Vintage" = c("#DDCDC3","#EAB595","#D37F6E","#B6542A","#8C3820"),
#   "Cyberpunk" = c("#00F5D4","#00BBF9","#FF006E","#FEE440","#9B5DE5"),
#   "Earth" = c("#E7E6D1","#C8C6AF","#A3A08C","#7D7A69","#57544A"),
#   "Galaxy" = c("#03045E","#0077B6","#00B4D8","#90E0EF","#CAF0F8"),
#   "Autumn" = c("#D4A373","#BC6C25","#606C38","#283618","#FEFAE0"),
#   "Rainbow" = c("#FF0000","#FF7F00","#FFFF00","#00FF00","#0000FF","#4B0082","#8F00FF")
# )
color_schemes <- ggstyle::paletteList

# ========== 自定义样式 ==========
custom_css <- "
.scheme-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 15px;
  padding: 10px;
}

.scheme-card {
  border-radius: 8px;
  overflow: hidden;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
  background: white;
  border: 1px solid #eee;
}

.scheme-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 20px rgba(0,0,0,0.1);
}

.scheme-card.active  {
  border: 2px solid #3498db !important;
  box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
}

.color-strip {
  display: flex;
  height: 40px;
  margin-bottom: 8px;
}

.color-chip {
  flex-grow: 1;
  transition: transform 0.2s;
}

.scheme-name {
  padding: 8px;
  text-align: center;
  font-weight: 500;
  color: #2c3e50;
}

.bg-glass {
  background: rgba(255, 255, 255, 0.9) !important;
  backdrop-filter: blur(10px) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
}

#resizable-plot .ui-resizable-handle {
  background: #3498db !important;
  opacity: 0.3;
  transition: opacity 0.3s;
}

.plot-tooltip {
  position: absolute;
  padding: 8px;
  background: rgba(52, 152, 219, 0.9);
  color: white;
  border-radius: 4px;
  pointer-events: none;
}

/* 核心高度控制 */
html, body {
  height: 100vh !important;
  overflow: hidden !important;
}

/* 主布局容器 */
.layout_columns {
  min-height: calc(100vh - 50px) !important;
  height: 100vh !important;
}

/* 卡片通用样式 */
.card {
  height: calc(100vh - 5px) !important; /* 留出顶部导航栏和边距空间 */
  display: flex !important;
  flex-direction: column !important;
  overflow: hidden !important;
}

/* 卡片内容区独立滚动 */
.card-body {
  flex: 1 1 auto !important;
  overflow-y: auto !important;
  padding-bottom: 15px !important;
}

/* 响应式调整 */
@media (max-height: 700px) {
  .card {
    height: calc(100vh - 70px) !important;
  }
}





"

# ========== UI界面 ==========
ui <- navbarPage(
    title = div(
    style = "display:none;"
    # img(src = "https://www.r-project.org/logo/Rlogo.png",  height = 30),
    # "配色方案预览工具"
  ),
  theme = bs_theme(
    version = 5,
    primary = "#3498db",
    # base_font = font_google("Noto Sans"),
    bootswatch = "flatly"
  ),
  # header = tags$style(HTML(custom_css)),
  header = tagList(
    tags$style(HTML(custom_css)),
    tags$style(HTML("
      .navbar {
        display: none !important;
      }
    ")),
    tags$link(
      href = "https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css",
      rel = "stylesheet"
    ),
    tags$script(
      src = "https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"
    ),
    tags$script(HTML('
  $(document).ready(function(){
    // 初始化时设置默认尺寸
    Shiny.addCustomMessageHandler("initPlotSize",  function(message) {
      $("#resizable-plot").css({
        width: "100%",
        height: message.height  + "px"
      });
      Shiny.setInputValue("plot_width",  message.width);
      Shiny.setInputValue("plot_height",  message.height);
    });
  });
')),
    tags$style(HTML("
  #more {
    display: none !important;  /* 完全移除元素占位 */
  }

"))
  ),



  layout_columns(
    col_widths = c(3, 3, 6),
    heights_equal = "row",

    # 左侧配色面板
    card(
      class = "color-picker",
      # h4("1. 选择配色方案", icon("palette")),
      h4(
        class = "control-title",
        tags$span(icon("palette", class = "me-2 text-primary"), "1. 选择配色方案"),
        style = "border-bottom: 2px solid #4a90e2; padding-bottom: 8px;"
      ),

      checkboxInput(inputId = "ifCustom",label = "是否要自定义配色方案",value = F),
      conditionalPanel(
        condition = "!input.ifCustom",
        uiOutput("colorSchemeUI")
      ),
      conditionalPanel(
        condition = "input.ifCustom",
        textInput(inputId = "customColor",
                  label = "输入16进制颜色，用,分隔",
                  value = "#F57C6E,#F8DA92,#86CDC8,#82B5EC,#F2A8DA",
                  width = "100%",
                  placeholder = "输入16进制颜色，用,分隔"
                  )
      ),

    ),

    # 中间控制台


    card(
      class = "control-panel",
      # h4("2. 控制参数", icon("sliders")),
      h4(
        class = "control-title",
        tags$span(icon("sliders", class = "me-2 text-primary"), "2. 参数调整"),
        style = "border-bottom: 2px solid #4a90e2; padding-bottom: 8px;"
      ),
      # sliderInput("color_num", "选择颜色数量",
      #             min = 2, max = 16, value = 8,ticks = T,step = 1,width = "100%"),
      numericInputIcon("color_num", "选择颜色数量",
                       min = 2, max = 16, value = 5,step = 1,width = "100%"),
      selectizeInput("whichPlot", "绘制哪些图形",
                     choices = c("柱形图" = "bar",
                                 "箱线图" = "box",
                                 "小提琴图" = "violin",
                                 "散点图" = "point2",
                                 "折线图"="line",
                                 "面积图"="area"),
                     selected=c("bar","violin","point2","line"),
                     multiple=T,width = "100%"),

      sliderInput("alpha", "选择颜色透明度",
                  min = 0, max = 1, value = 1,ticks = F,step = 0.1,width = "100%"),
      # checkboxInput(inputId = "more",label = "更多参数"),
      checkboxInput(
        "more",
        label = div(
          icon("cogs", class = "me-2"),  # 添加右侧间距
          "更多参数配置",
          class = "text-warning fw-medium"  # 启用Flex布局并垂直居中
        ),
        width = "100%",
        value=F
      ),
      conditionalPanel(
        condition = "input.more",

        # radioGroupButtons("modeColor", "绘图的模式",
        #             choices = c("自动选择" = "auto",
        #                         "一个接一个" = "1")),
        radioGroupButtons(
          inputId = "modeColor",
          label = div("当选取颜色个数,小于配色方案里颜色个数时",
                      id = "modeColorHelp"),
          choices = c("自动选择" = "auto", "一个接一个" = "1"),
        width="100%"
        ),
        checkboxInput(inputId = "ifHexAlpha","Hex代码是否显示透明度",value = F),
        checkboxInput(inputId = "ifRev","颜色翻转",value = F)
      ),



    ),

    # 右侧展示区
    card(
      full_screen = TRUE,
      # h4("3. 预览效果", icon("image")),
      h4(
        class = "control-title",
        tags$span(icon("image", class = "me-2 text-primary"), "3. 预览效果"),
        style = "border-bottom: 2px solid #4a90e2; padding-bottom: 8px;"
      ),
      # card_header("3. 实时预览"),
      # plotOutput("previewPlot", height = "600px"),
      div(id = "resizable-plot",
          plotOutput("previewPlot")
                     # hover = hoverOpts("plot_hover"),
                     # dblclick = "plot_dblclick")
      ),

      tags$script('
  $(document).ready(function(){
    var $el = $("#resizable-plot");
    var debounceTimer;
    $el.resizable({
      handles: "all",
      resize: function(event, ui) {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(function() {
          Shiny.setInputValue("plot_width",  ui.size.width,  {priority: "event"});
          Shiny.setInputValue("plot_height",  ui.size.height,  {priority: "event"});
        }, 300); // 100ms防抖间隔
      }
    });
  });
'),
      tags$h4("配色方案参数："),
      verbatimTextOutput("scheme_info")
      # navset_card_underline(
      #   nav_panel("方案参数", verbatimTextOutput("scheme_info"))#,
      #   # nav_panel("颜色数据", DT::dataTableOutput("color_data"))
      # )
    )
  )
)

#   resize: function(event, ui) {
#   Shiny.setInputValue("plot_size",  {
#     width: ui.size.width,
#     height: ui.size.height,
#     timestamp: Date.now()
#   });
# }

# ========== 服务器逻辑 ==========
server <- function(input, output, session) {
  selected_scheme <- reactiveVal(names(color_schemes)[2])

  # 生成配色方案选择器
  output$colorSchemeUI <- renderUI({
    div(class = "scheme-container",
        lapply(names(color_schemes), function(name){
          colors <- color_schemes[[name]]
          div(class = paste("scheme-card", ifelse(name == selected_scheme(), "active", "")),
              onclick = paste0("Shiny.setInputValue('selected_scheme',  '", name, "')"),
              div(class = "color-strip",
                  lapply(colors, function(col){
                    div(class = "color-chip",
                        style = paste0("background:", col,
                                       "; width:", 100/length(colors), "%;"))
                  })
              ),
              div(class = "scheme-name", name)
          )
        })
    )
  })

  # 更新选中方案
  observeEvent(input$selected_scheme, {
    selected_scheme(input$selected_scheme)
  })



  # 在server函数中添加以下代码
  observe({
    # 初始化绘图区域尺寸（默认值）
    session$sendCustomMessage(
      type = "initPlotSize",
      message = list(width = 800, height = 600)
    )
  })

  plot_dim <- reactive({
    req(input$plot_width, input$plot_height)
    list(w = input$plot_width, h = input$plot_height)
  }) %>% debounce(200)  # 合并宽高更新事件


  # 实时预览图形
  output$previewPlot <- renderPlot({
    # req(input$plot_width)
    # print(plot_width())

    if(!input$ifCustom){
      myPalette = selected_scheme()
      if(input$ifRev){
        revColor = T
      }else{
        revColor = F
      }
    }else{
      myPalette = get_colors()
      revColor= F
    }


    example_plot(ncolor = input$color_num,palette = myPalette,modeColor = input$modeColor,whichPlot =input$whichPlot,alp = input$alpha,revColor=revColor)
  }
  # ,height = plot_height,width = plot_width
  , height = function() plot_dim()$h,
  # width = function() plot_dim()$w
  )



  # 获取当前颜色方案
  get_colors <- reactive({
    if(!input$ifCustom){
      req(selected_scheme())
      # scheme <- color_schemes[[selected_scheme()]]
      # scheme[1:min(input$color_num, length(scheme))]
      scheme = palette2color(palette = selected_scheme(),modeColor = input$modeColor,n = input$color_num)
      scheme
    }else{
      # color_str <- "#F57C6E ,#F8DA92，#86CDC8，#82B5EC,#F2A8DA"  # 含中英文逗号的示例

      # 分割字符串（兼容中英文逗号）
      color_str = strsplit(input$customColor, split = "[,，]")[[1]] %>%
        trimws()  # 去除前后空格（防冗余）
      scheme = palette2color(palette = color_str,modeColor = input$modeColor,n = input$color_num)
      # scheme = "自定义"

    }

    if(input$ifRev){
      scheme = rev(scheme)
    }
    scheme


  })

  # 显示方案信息
  output$scheme_info <- renderPrint({

    if(input$ifCustom){
      myColorType = "自定义"
    }else{
      myColorType = selected_scheme()
    }
    cat("当前方案：", myColorType, "\n")
    cat("颜色数量：", input$color_num, "\n")
    cat("HEX编码：")
    # print(get_colors())

    if(!input$ifHexAlpha){
      dput(get_colors())
    }else{
      dput(adjustcolor(get_colors(), alpha.f = input$alpha))
    }
  })

  # # 颜色数据表格
  # output$color_data <- DT::renderDataTable({
  #   data <- data.frame(
  #     Scheme = selected_scheme(),
  #     Color = get_colors(),
  #     RGB = sapply(get_colors(), function(x) paste(col2rgb(x)[,1], collapse=", "))
  #   )
  #   DT::datatable(data, options = list(dom = 't'))
  # })
}

# ========== 启动应用 ==========
shinyApp(ui, server)
