library(devtools)

load_all()


# 需要加载的包
use_package("ggplot2",type = "Imports")
use_package("scales",type = "Imports")
use_package("ggthemes",type = "Suggests")




# 脚本
use_r("color")
use_r("theme")

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

