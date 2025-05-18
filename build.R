library(devtools)

load_all()

devtools::install()


# 需要加载的包
use_package("ggplot2",type = "Imports")
use_package("scales",type = "Imports")

use_package("ggthemes",type = "Suggests")
use_package("dplyr",type = "Suggests")
use_package("tidyr",type = "Suggests")



# 脚本
use_r("color")
use_r("theme")
use_r("plot")
use_r("plot2")

# 说明
use_vignette("ggstyle", "ggstyle")
devtools::build_vignettes()
browseVignettes("ggstyle")


document()

# 许可证
use_gpl3_license()




# git remote add origin https://github.com/sz-zyp/ggstyle.git
# git branch -M main
# git push -u origin main





library(devtools)

load_all()
p1 = plotPoint(palette = "rainbow1",modeColor = "auto")
p2 = plotViolin(palette = "rainbow1",modeColor = "auto")
p3 = plotFlower(palette = "rainbow1",modeColor = "auto")
p4 = plotFillbar(palette = "jama",modeColor = "auto")


library(patchwork)
(p1 | p2) / (p4 + p4)
