#' example_plot
#'
#' @param ncolor n color
#' @param palette  A character string specifying the name of the color palette.
#' @param modeColor Mode of color selection; default is "auto". If "1", colors are applied one by one.
#' @param alp alpha
#' @param whichPlot c("bar","violin","point","line","area","box")
#'
#' @import dplyr
#' @import patchwork
#'
#' @returns
#' @export
#'
#' @examples example_plot(ncolor = 8,palette = "rainbow1",modeColor = "auto")
example_plot  = function(ncolor = 8,
                       palette="rainbow1",
                       modeColor = "auto",
                       alp=1,
                       whichPlot=c("bar","violin","point","line"),
                      revColor = F
                       ){


  # ncolor = 8
  # palette="rainbow1"
  # modeColor = "auto"
  # alp = 1
  # whichPlot=c("bar","violin","point","line")

  colorList = palette2color(palette = palette,modeColor = modeColor,n = ncolor)
  if(revColor){
    colorList = rev(colorList)
  }

  # 图1.bar
  if("bar" %in% whichPlot){
    set.seed(123)
    dat_bar= data.frame(a=letters[1:ncolor],
                        b=runif(ncolor, 7, 10))

    p_bar= ggplot(dat_bar, aes(a, b, fill=a))+
      geom_bar(color="black", stat = "identity", alpha=alp)+
      scale_y_continuous(expand = c(0,0,0,0.1))+
      scale_fill_manual(values = colorList)+
      labs(x="x", y="y", title = "")+
      ggstyle::theme_style1()+theme(legend.position = "none")
  }else{
    p_bar = NULL
  }

  if("box" %in% whichPlot){
    # 图2.box
    set.seed(123)
    dat_box= data.frame(a=letters[1:ncolor],
                        b=runif(ncolor*20, 7, 10))
    p_box= ggplot(dat_box, aes(a, b, fill=a))+
      # stat_boxplot(geom = "errorbar", linewidth=0.8, width = 0.3)+
      geom_boxplot(alpha=alp)+
      scale_fill_manual(values = colorList)+
      labs(x="x", y="y", title = "")+
      ggstyle::theme_style1()+theme(legend.position = "none")
  }else{
    p_box = NULL
  }

  if("point" %in% whichPlot){
    # 图3.point
    set.seed(123)
    dat_point= data.frame(a=rep(runif(30), ncolor),
                          b=rep(runif(30), ncolor),
                          t=rep(letters[1:ncolor], 30))

    p_point= ggplot(dat_point, aes(a, b, color=t, fill=t))+
      geom_point(shape=21, size=5, alpha=alp)+
      scale_color_manual(values = colorList)+
      scale_fill_manual(values = colorList)+
      labs(x="x", y="y", title = "")+
      ggstyle::theme_style1()+theme(legend.position = "none")
  }else{
    p_point = NULL
  }

  if("line" %in% whichPlot){
    # 图4.line
    set.seed(123)
    dat_line= data.frame(a=rep(1:20, ncolor),
                         b=rep(1:ncolor, each=20)+rnorm(20*ncolor, 0, 0.3),
                         t=rep(sample(letters, ncolor), each=20))
    p_line= ggplot(dat_line, aes(a, b, color=t, group=t))+
      geom_line(linewidth=1, alpha=alp)+
      scale_color_manual(values = colorList)+
      labs(x="x", y="y", title = "")+
      ggstyle::theme_style1()+theme(legend.position = "none")
  }else{
    p_line = NULL
  }

  if("area" %in% whichPlot){
    # 图5.area
    set.seed(123)
    dat_line= data.frame(a=rep(1:20, ncolor),
                         b=rep(1:ncolor, each=20)+rnorm(20*ncolor, 0, 0.3),
                         t=rep(sample(letters, ncolor), each=20))
    p_area= ggplot(dat_line, aes(a, b, color=t,fill=t, group=t))+
      geom_area(linewidth=0.5, alpha=alp,color="white")+
      scale_color_manual(values = colorList)+
      scale_fill_manual(values = colorList)+
      labs(x="x", y="y", title = "")+
      ggstyle::theme_style1()+theme(legend.position = "none")
  }else{
    p_area = NULL
  }

  if("violin" %in% whichPlot){
    # 图6.
    set.seed(123)
    dat_box= data.frame(a=letters[1:ncolor],
                        b=runif(ncolor*20, 7, 10))
    p_violin= ggplot(dat_box, aes(a, b, fill=a))+
      # stat_boxplot(geom = "errorbar", linewidth=0.8, width = 0.3)+
      # geom_boxplot()+
      # geom_violin(alpha=alp)+

      geom_violin(alpha = alp,              # 透明度
                  color="white",
                  trim = F,               # 是否修剪尾巴，即将数据控制到真实的数据范围内
                  scale = "count",         # 如果“area”(默认)，所有小提琴都有相同的面积(在修剪尾巴之前)。如果是“count”，区域与观测的数量成比例。如果是“width”，所有的小提琴都有相同的最大宽度。

      )+
      geom_boxplot(width=0.16,
                   fill="white",
                   alpha=alp-0.1,
                   color="black",

                   outlier.alpha = 1
      )+
      scale_fill_manual(values = colorList)+
      labs(x="x", y="y", title = "")+
      ggstyle::theme_style1()+theme(legend.position = "none")
  }else{
    p_violin = NULL
  }


  if("point2" %in% whichPlot){
    # 图 point2
    # 设置n和组的数量
    n = 100  # 每组的样本数量
    num_groups = ncolor  # 总共24组

    # 初始化空的x、y和group向量
    a = c()
    b = c()
    t = c()

    # 循环生成每组数据
    for (i in 1:num_groups) {
      # 为每组生成x和y数据，可以根据组号自定义mean和sd
      a = c(a, rnorm(n, mean=5 + 2 * i, sd=1.5 ))  # x的数据
      # 判断一个数是否是奇数
      is_odd = function(x) {
        return(x %% 2 != 0)  # 如果除以2的余数不为0，则是奇数
      }

      # 示例
      if(is_odd(i)){
        b = c(b, rnorm(n, mean=runif(1,8,12), sd=1 + 0.5 ))  # y的数据
      }else{
        b = c(b, rnorm(n, mean=runif(1,4,6), sd=1 ))  # y的数据
      }

      t = paste0("a",c(t, rep(i, n)))  # 为每个数据点分配组号
    }

    # 创建数据框
    dat_point2 = data.frame(a, b, group=as.factor(t))

    # 查看前几行数据
    # head(dat_point)

    p_point2= ggplot(dat_point2, aes(a, b, color=t, fill=t))+
      geom_point(shape=21, alpha=alp)+
      scale_color_manual(values = colorList)+
      scale_fill_manual(values = colorList)+
      labs(x="x", y="y", title = "")+
      ggstyle::theme_style1()+theme(legend.position = "none")

  }else{
    p_point2 = NULL
  }

  # 合并
  # library(patchwork)


  # p_bar
  # p_box
  # p_point
  # p_line
  # p_violin
  # p_area
  # p_point2

  # whichPlot=c("point2","box","bar","violin","point","line")


  # 创建图形对象列表（名称与变量严格对应）
  plot_list = list(
    bar    = p_bar,    # 柱状图
    box    = p_box,    # 箱线图
    point  = p_point,  # 散点图
    line   = p_line,   # 折线图
    violin = p_violin, # 小提琴图
    area   = p_area,   # 面积图
    point2 = p_point2  # 备用散点图
  )

  # 根据 whichPlot 筛选图形
  selected_plots = plot_list[whichPlot]
  selected_plots = purrr::compact(selected_plots)


  optimal_cols = ceiling(sqrt(length(selected_plots)))
  p_total = patchwork::wrap_plots(selected_plots, ncol = optimal_cols)

  return(p_total)
}


