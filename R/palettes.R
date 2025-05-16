# color palettes data

paletteList <- vector("list")
paletteList$"ggplot2" = c("#f27970","#bb9727","#54b345","#32b897","#05b9e2","#8983bf","#c76da2")


# 互联网----
paletteList$"rainbow1" =  c("#f57c6e","#f2b56e","#fbe79e","#84c3b7","#88d7da","#71b8ed","#b8aeea","#f2a8da")
# paletteList$"color2" =  c("#529dca","#71be50","#f3cc4e","#eca063","#d56935")

# 配色方案 2：柔和梦幻色系
# 中文名字：梦幻轻语
# 英文变量名：DreamyWhisper
DreamyWhisper = c("#a1a9d0","#f0988c","#b883d3","#9e9e9e","#cfeaf1","#c4a5de","#f6cae5","#96cccb")
paletteList$"DreamyWhisper" = DreamyWhisper

# 配色方案 3：自然活力色系
# 中文名字：自然律动
# 英文变量名：NatureRhythm
NatureRhythm = c("#a30543","#f36f43","#fbda83","#e9f4a3","#80cba4","#4965b0")
paletteList$"NatureRhythm" = NatureRhythm

# 配色方案 4：神秘浪漫色系
# 中文名字：神秘绮梦
# 英文变量名：MysticDream
MysticDream = c("#16058b","#6200aa","#9e169d","#cc4a74","#eb7852","#fcb431")
paletteList$"MysticDream" = MysticDream

# 配色方案 5：科技未来色系
# 中文名字：未来之光
# 英文变量名：FutureGlow
FutureGlow = c("#44035b","#404185","#31688e","#1f918d","#38b775","#90d543","#f8e620")
paletteList$"FutureGlow" = FutureGlow

# 配色方案 6：日落黄昏色系
# 中文名字：黄昏绮景
# 英文变量名：TwilightScenery
TwilightScenery = c("#274753","#297270","#299d8f","#8ab07c","#e7c66b","#f3a361","#e66d50")
paletteList$"TwilightScenery" = TwilightScenery
# 配色方案 7：经典对比色系
# 中文名字：经典碰撞
# 英文变量名：ClassicContrast
ClassicContrast = c("#7a0101","#be1420","#fbf0d9","#012f48","#669aba")
paletteList$"ClassicContrast" = ClassicContrast

# 配色方案 8：清新淡雅色系
# 中文名字：清新雅韵
# 英文变量名：FreshElegance
FreshElegance = c("#fbf1c2","#566970","#e67a7f","#9d3151","#87baa7")
paletteList$"FreshElegance" = FreshElegance



# RColorBrewer----
paletteList$"Set1" =  c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF")
paletteList$"Set2" =  c("#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F",
                        "#E5C494", "#B3B3B3")
paletteList$"Set3" =  c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462",
                        "#B3DE69", "#FCCDE5", "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")




# ggsci ----


# Color palette inspired by plots in Nature Reviews Cancer
paletteList$"npg" <- c(
  "Cinnabar" = "#E64B35", "Shakespeare" = "#4DBBD5",
  "PersianGreen" = "#00A087", "Chambray" = "#3C5488",
  "Apricot" = "#F39B7F", "WildBlueYonder" = "#8491B4",
  "MonteCarlo" = "#91D1C2", "Monza" = "#DC0000",
  "RomanCoffee" = "#7E6148", "Sandrift" = "#B09C85"
)

# Color palette from BMJ living style guide
# https://technology.bmj.com/living-style-guide/colour.html
paletteList$"bmj" <- c(
  "Blue" = "#2A6EBB",
  "Yellow" = "#F0AB00",
  "Pink" = "#C50084",
  "Purple" = "#7D5CC6",
  "Orange" = "#E37222",
  "Green" = "#69BE28",
  "Aqua" = "#00B2A9",
  "Red" = "#CD202C",
  "Grey" = "#747678"
)

# Color palette inspired by plots in Science from AAAS
paletteList$"aaas" <- c(
  "Chambray" = "#3B4992", "Red" = "#EE0000",
  "FunGreen" = "#008B45", "HoneyFlower" = "#631879",
  "Teal" = "#008280", "Monza" = "#BB0021",
  "ButterflyBush" = "#5F559B", "FreshEggplant" = "#A20056",
  "Stack" = "#808180", "CodGray" = "#1B1919"
)

# Color palette inspired by plots in The New England Journal of Medicine
paletteList$"nejm" <- c(
  "TallPoppy" = "#BC3C29", "DeepCerulean" = "#0072B5",
  "Zest" = "#E18727", "Eucalyptus" = "#20854E",
  "WildBlueYonder" = "#7876B1", "Gothic" = "#6F99AD",
  "Salomie" = "#FFDC91", "FrenchRose" = "#EE4C97"
)

# Color palette inspired by plots in Lancet Oncology
paletteList$"lancet" <- c(
  "CongressBlue" = "#00468B", "Red" = "#ED0000",
  "Apple" = "#42B540", "BondiBlue" = "#0099B4",
  "TrendyPink" = "#925E9F", "MonaLisa" = "#FDAF91",
  "Carmine" = "#AD002A", "Edward" = "#ADB6B6",
  "CodGray" = "#1B1919"
)

# Color palette inspired by plots in The Journal of the American Medical Association
paletteList$"jama" <- c(
  "Limed Spruce" = "#374E55", "Anzac" = "#DF8F44",
  "Cerulean" = "#00A1D5", "Apple Blossom" = "#B24745",
  "Acapulco" = "#79AF97", "Kimberly" = "#6A6599",
  "Makara" = "#80796B"
)



# Color palette inspired by plots in Journal of Clinical Oncology
paletteList$"jco" <- c(
  "Lochmara" = "#0073C2", "Corn" = "#EFC000",
  "Gray" = "#868686", "ChestnutRose" = "#CD534C",
  "Danube" = "#7AA6DC", "RegalBlue" = "#003C67",
  "Olive" = "#8F7700", "MineShaft" = "#3B3B3B",
  "WellRead" = "#A73030", "KashmirBlue" = "#4A6990"
)



# Color palette from D3.js
paletteList$"d3.category10" <- c(
  "Matisse" = "#1F77B4", "Flamenco" = "#FF7F0E",
  "ForestGreen" = "#2CA02C", "Punch" = "#D62728",
  "Wisteria" = "#9467BD", "SpicyMix" = "#8C564B",
  "Orchid" = "#E377C2", "Gray" = "#7F7F7F",
  "KeyLimePie" = "#BCBD22", "Java" = "#17BECF"
)

# Color palette from D3.js
paletteList$"d3.category20" <- c(
  "Matisse" = "#1F77B4", "Flamenco" = "#FF7F0E",
  "ForestGreen" = "#2CA02C", "Punch" = "#D62728",
  "Wisteria" = "#9467BD", "SpicyMix" = "#8C564B",
  "Orchid" = "#E377C2", "Gray" = "#7F7F7F",
  "KeyLimePie" = "#BCBD22", "Java" = "#17BECF",
  "Spindle" = "#AEC7E8", "MaC" = "#FFBB78",
  "Feijoa" = "#98DF8A", "MonaLisa" = "#FF9896",
  "LavenderGray" = "#C5B0D5", "Quicksand" = "#C49C94",
  "Chantilly" = "#F7B6D2", "Silver" = "#C7C7C7",
  "Deco" = "#DBDB8D", "RegentStBlue" = "#9EDAE5"
)



# Observable 10 color palette
paletteList$"observable10" <- c(
  "Blue" = "#4269D0",
  "Orange" = "#EFB118",
  "Red" = "#FF725C",
  "Cyan" = "#6CC5B0",
  "Green" = "#3CA951",
  "Pink" = "#FF8AB7",
  "Purple" = "#A463F2",
  "LightBlue" = "#97BBF5",
  "Brown" = "#9C6B4E",
  "Gray" = "#9498A0"
)



