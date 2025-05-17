# 此脚本是生成固定的4个图片（散点图，小提琴图，花瓣图，百分比柱形图），可以改变配色方案


#' 散点图
#'
#' @param palette A character string specifying the name of the color palette.
#' @param modeColor Mode of color selection; default is "auto". If "1", colors are applied one by one.
#'
#' @returns
#' @export
#'
#' @examples plotPoint(palette = "rainbow1",modeColor = "auto")
plotPoint = function(palette="rainbow1",modeColor = "auto"){
  # palette = "rainbow1"
  # 散点图
  set.seed(123)  # 设置随机种子，确保结果可复现

  # 生成8组数据
  n <- 200  # 每组数据点数量
  groups <- factor(rep(1:8, each=n))  # 8组数据

  # 生成x, y坐标
  x <- c(
    rnorm(n, mean=5, sd=1),  # 组1
    rnorm(n, mean=5, sd=1.5),  # 组2
    rnorm(n, mean=9, sd=1),  # 组3
    rnorm(n, mean=9, sd=1.5),  # 组4
    rnorm(n, mean=13, sd=1),  # 组5
    rnorm(n, mean=14, sd=1.5),  # 组6
    rnorm(n, mean=18, sd=1),  # 组7
    rnorm(n, mean=19, sd=1.5)  # 组8
  )

  y <- c(
    rnorm(n, mean=5, sd=1),  # 组1
    rnorm(n, mean=10, sd=1.5),  # 组2
    rnorm(n, mean=4, sd=1),  # 组3
    rnorm(n, mean=8, sd=1.5),  # 组4
    rnorm(n, mean=7, sd=1),  # 组5
    rnorm(n, mean=12, sd=1.5),  # 组6
    rnorm(n, mean=6, sd=1),  # 组7
    rnorm(n, mean=9, sd=1.5)  # 组8
  )

  # 创建数据框
  data <- data.frame(x, y, group=groups)

  data2 = data.frame(
    "x"=c(5,5,9,9,13,14,18,19),
    "y"=c(5,10,4,8,7,12,6,9),
    "label"=c("A","B","C","D","E","F","G","H")
  )

  # 绘制分组散点图
  ggplot(data, aes(x=x, y=y, color=group)) +
    geom_point(size=2) +  # 散点图
    geom_text(mapping = aes(x=x,y=y,label=label),data = data2,color="black")+
    theme_style1()+
    scale_color_sci(
      palette = palette,
      type = "discrete",
      modeColor = modeColor,
      direction = -1
    )+
    guides(color=guide_legend(nrow=1, byrow=T,reverse = F))+
    theme(legend.position = "none")
}



#' 小提琴图
#'
#' @param palette A character string specifying the name of the color palette.
#' @param modeColor Mode of color selection; default is "auto". If "1", colors are applied one by one.
#'
#' @returns
#' @export
#'
#' @examples plotViolin(palette = "rainbow1",modeColor = "auto")
plotViolin = function(palette="rainbow1",modeColor = "auto"){
  # palette="rainbow1"
  # modeColor = "auto"


  # 小提琴图
  data <- data.frame(
    Value = c(c(rnorm(20, mean = 50, sd = 10)),   # Group 1
              rnorm(20, mean = 60, sd = 15),   # Group 2
              rnorm(20, mean = 55, sd = 12),   # Group 3
              c(rnorm(20, mean = 55, sd = 11))),   # Group 4
    Sample = factor(rep(c("Sample 1", "Sample 2", "Sample 3", "Sample 4"), each = 20))
  )

  ggplot(data,aes(x=Sample,y=Value,fill=Sample))+
    # stat_boxplot(geom = "errorbar",    # 添加误差线
    #  width=0.3)+
    geom_violin(alpha = 1,              # 透明度
                color="white",
                trim = F,               # 是否修剪尾巴，即将数据控制到真实的数据范围内
                scale = "count",         # 如果“area”(默认)，所有小提琴都有相同的面积(在修剪尾巴之前)。如果是“count”，区域与观测的数量成比例。如果是“width”，所有的小提琴都有相同的最大宽度。

    )+
    geom_boxplot(width=0.16,
                 fill="white",
                 alpha=0.8,
                 color="black",

                 outlier.alpha = 1
    )+
    theme(
      legend.position = "none"
    )+
    theme_style1()+
    scale_fill_sci(
      palette = palette,
      type = "discrete",
      modeColor = modeColor,
      direction = -1
    )+
    guides(fill=guide_legend(nrow=1, byrow=T,reverse = F))+
    theme(legend.position = "none")
}



#' 花瓣图
#'
#' @param palette A character string specifying the name of the color palette.
#' @param modeColor Mode of color selection; default is "auto". If "1", colors are applied one by one.
#'
#' @returns
#' @export
#'
#' @examples plotFlower(palette = "rainbow1",modeColor = "auto")
plotFlower = function(palette="rainbow1",modeColor = "auto"){
  # palette="rainbow1"
  # modeColor = "auto"

  # 花瓣图

  # 来源 https://www.r2omics.cn/
  #'  花瓣图
  #' @param sample 样本名称向量
  #' @param num 数量向量
  #' @param core 核心数量
  #' @param start 起始角度(0-360度)
  #' @param a 椭圆长轴长度
  #' @param b 椭圆短轴长度
  #' @param r 中心圆半径
  #' @param ellipse_col 椭圆颜色向量
  #' @param circle_col 中心圆颜色
  #' @param alpha 透明度
  #' @param nameSize 名称大小
  #' @param numSize 数字大小
  #' @param coreSize 共有名称大小
  flower_plot <- function(sample, num, core, start = 90, a = 0.5, b = 2,
                          r = 1, ellipse_col, circle_col = "white",alpha,
                          nameSize=0.9,numSize=0.8,coreSize=1.2) {
    ellipse_col = adjustcolor(ellipse_col, alpha.f = alpha)


    # 设置图形参数：无边框/坐标轴/边距，强制正方形输出
    par(bty = 'n', ann = F, xaxt = 'n', yaxt = 'n', mar = c(0,0,0,0), pty = "s")

    # 创建标准化坐标系统(0-10范围保证绘图比例)
    plot(c(0,10), c(0,10), type = 'n', asp = 1)  # asp=1强制坐标轴等比例

    n <- length(sample)
    deg <- 360 / n  # 计算每个样本的间隔角度

    # 循环绘制每个样本的椭圆和标签
    lapply(seq_len(n), function(t) {
      # 计算当前椭圆中心坐标(极坐标转换)
      angle <- (start + deg * (t - 1)) * pi / 180
      x_center <- 5 + cos(angle)
      y_center <- 5 + sin(angle)

      # 绘制椭圆花瓣
      plotrix::draw.ellipse(
        x = x_center,
        y = y_center,
        col = ellipse_col[t],
        border = ellipse_col[t],
        a = a, b = b,
        angle = deg * (t - 1)  # 椭圆旋转角度
      )

      # 添加数量标签(内层文字)
      text(
        x = x_center + (b-0.5) * cos(angle),  # 0.5为偏移系数
        y = y_center + (b-0.5) * sin(angle),
        labels = num[t],
        cex = numSize
      )

      # 添加样本名称标签(外层文字)
      text(
        x = 5 + (b+1.3)  * cos(angle),
        y = 5 + (b+1.3)  * sin(angle),
        labels = sample[t],
        srt = ifelse(deg*(t-1) < 180 && deg*(t-1) > 0,
                     deg*(t-1) - start,
                     deg*(t-1) + start),  # 自动调整文字旋转角度
        adj = ifelse(deg*(t-1) < 180 && deg*(t-1) > 0, 1, 0),  # 自动对齐方式
        cex = nameSize
      )
    })

    # 绘制中心圆
    plotrix::draw.circle(5,  5, r, col = circle_col, border = NA)
    text(5, 5, paste('Core:', core), cex = coreSize, font = 2)
  }
  flower_plot(
    sample = paste0("A",1:15),  # 样本名称向量
    num = 1:15,                 # 数量向量
    core = 12,                  # 核心数量
    ellipse_col = palette2color(palette,n = 15,modeColor = modeColor),
    start = 90,
    a = 0.6,      # 椭圆长度
    b = 2,        # 椭圆宽度
    r = 1,        # 中心圆半径
    alpha=0.7,    # 颜色透明度
    nameSize=0.9, # 名称大小
    numSize=0.8,  # 数字大小
    coreSize=1.2  # 共有名称大小
  )

}



#' 百分比柱形图
#'
#' @param palette A character string specifying the name of the color palette.
#' @param modeColor Mode of color selection; default is "auto". If "1", colors are applied one by one.
#'
#' @import dplyr
#'
#' @returns
#' @export
#'
#' @examples plotFillbar(palette = "rainbow1",modeColor = "auto")
plotFillbar = function(palette="rainbow1",modeColor = "1"){
  # palette="rainbow1"
  # modeColor = "auto"

  # 百分比柱形图
  data("diamonds")

  data = diamonds[1:690,] %>%
    select(cut,depth,color) %>%
    bind_rows(data.frame(
      cut = c("Ideal","Premium","Very Good","Good","Fair"),
      depth = c(200,100,320,1240,143),
      color = c("K","K","K","K","K")
    ))

  ggplot(
    data,
    aes(x =cut , y=depth,fill = color  )
  ) +
    geom_bar(              # 绘制柱形图，核心是position="fill"
      position="fill",
      stat="identity"
    )+
    theme_style1()+
    scale_fill_sci(
      palette = palette,
      type = "discrete",
      modeColor = modeColor,
      name = "Cylinders",
      direction = -1
    )+
    guides(fill=guide_legend(nrow=1, byrow=T))+
    theme(legend.position = "none")

}
