# 鹏城实验室 Beamer 模板

采用蓝白配色，使用 XeLaTeX + Beamer，固定为 160 × 90 mm 的 16:9 画布。封面、正文、目录和结束页均使用“鹏城实验室”Logo。模板提供通用版式与演示内容，便于复用和扩展。

## 文件

| 文件 | 用途 |
| --- | --- |
| `beamerthemePCL.sty` | 主题、封面、自动分页目录、标题区和正文组件 |
| `pclplots.sty` | 可选的 PGFPlots 科研图表样式 |
| `main.tex` / `main.pdf` | 正式写作入口，保留占位封面和结束页 |
| `demo.tex` / `demo.pdf` | 14 页版式示例，包括大图、双图、框图和照片 |
| `assets/` | Logo、楼宇照片和结束页背景 |
| `build.ps1` / `latexmkrc` | 自动编译配置 |

## 编译

在本文件夹打开 PowerShell：

```powershell
.\build.ps1 -Target demo
.\build.ps1 -Target main
```

脚本使用 `latexmk` 驱动 XeLaTeX，按需要重复编译直到目录、页码与交叉引用稳定，成功后更新模板文件夹中的 PDF。需要 TeX Live 及 Beamer、ctex、TikZ、tcolorbox；图表示例还需要 pgfplots。已在本机 TeX Live 2025 验证。

所有辅助文件放在上一级目录的 `tmp/pcl_beamer-build/` 中。也可以执行 `latexmk -xelatex main.tex`，此时 PDF 保留在该临时构建目录。不要用没有输出目录参数的裸编译命令，以免在模板目录留下辅助文件。

中文优先使用微软雅黑，缺失时回退到 Fandol 黑体；西文优先使用 Arial，缺失时回退到 TeX Gyre Heros。PDF 嵌入所用字体，不需要接收方安装字体。

## 开始写作

```latex
\documentclass[aspectratio=169,11pt]{beamer}
\usetheme{PCL}
% \usepackage{pclplots} % 仅使用科研绘图样式时需要

\title{报告标题}
\subtitle{可选副标题}
\author{汇报人姓名}
\institute{鹏城实验室}
\date{\PCLCurrentYearMonth}

\begin{document}
\PCLTitleFrame
\PCLContentsFrame
\PCLSectionFramesOn

\PCLSection[研究方法]{研究方法的完整名称}
\begin{frame}{页面标题}
  \framesubtitle{可选的实验条件或补充说明}
  正文内容
\end{frame}

\PCLClosingFrame
\end{document}
```

普通 `\section{章节名称}` 同样支持。`\PCLSection[目录短名称]{完整名称}` 额外为主题目录提供短名称；原生 Beamer 的 `\section[短名称]{完整名称}` 只影响导航，原生目录通常仍使用完整名称。

## 封面与目录的边界

- 封面先测量全部文字的实际高度，常规样式容纳不超过 37 mm 的信息块。较长标题或多行单位会切换为紧凑样式，仍保持居中和信息顺序。
- 推荐封面标题一至两行；三行标题可使用紧凑样式。紧凑样式也放不下时，编译会给出 `Cover text exceeds the safe area` 错误，应精简标题、副标题、作者或单位。模板不会无限缩小字号。
- 空副标题、空单位不会留下专门的空行。年月默认取编译时的系统年月，PDF 打开时不会重新计算；需要固定日期时改用 `\date{2026年10月}` 等明确文本。
- `\PCLContentsFrame` 按每条目录的实际高度自动分页，条目不会跨页；目录字体不随章节增加而缩小。单个条目过长时会给出明确错误。
- `\PCLSectionFrame` 只展示当前章节所在的目录分页。当前章节为 `#C00000`，其他章节为蓝色；多页目录显示页内的“目录 i / n”标识。
- `\PCLSectionFramesOn` 自动插入章节过渡页，`\PCLSectionFramesOff` 关闭。启用自动模式后不需要再手动插入相同章节页。
- 主题目录显示当前 `\part` 的一级章节，保留章节跳转链接。需要二级目录等特殊布局时，可在普通页面使用原生 `\tableofcontents`。

## 页面布局与设置

普通内容页默认顶部对齐；需要居中时使用 `\begin{frame}[c]{标题}`。标题区按实际行数占用高度，支持 `\framesubtitle`；正文会随标题高度向下移动。正文长标题建议控制在两行以内，避免压缩图表空间。

常用参数可在导言区统一设置：

```latex
\PCLSetup{
  margin=5.5mm,
  title left=20.8mm,
  title right=18mm,
  title top=4.7mm,
  title gap=2mm,
  logo size=10.4mm,
  toc gap=4mm,
  title color=PCLTitleRed
}
```

`title left`、`title right` 指标题区相对于纸张边缘的左右留白；`title top` 是标题模板的顶部间距，`title gap` 是标题与正文之间的间距。`logo size` 只控制正文右上角 Logo。调整参数后应重新检查标题是否避开装饰和 Logo。背景画布与封面图形位置保持原比例，不建议随意修改纸张尺寸。

颜色、字号也可用标准 Beamer 接口覆盖，如：

```latex
\setbeamerfont{frametitle}{size=\fontsize{15}{18}\selectfont}
\setbeamerfont{section in toc}{size=\fontsize{13}{18}\selectfont}
```

## 正文组件

| 命令 | 功能 |
| --- | --- |
| `\PCLLead[标签]{说明}` | 浅蓝色说明条 |
| `\begin{PCLPanel}[参数]{标题} ... \end{PCLPanel}` | 带蓝色标题栏的内容卡片 |
| `\PCLTakeaway{结论}` | 蓝底白字结论条，默认与正文同级字号 |
| `\PCLHeading{小标题}` | 无框版式的蓝色小标题 |
| `\PCLImage[最大宽度]{最大高度}{文件}` | 保持比例的图片，不引入 `center` 环境的额外间距 |
| `\PCLFigureCaption{图注}` | 10 pt 图注，适合解释测试条件与图中对象 |
| `\PCLSource{来源}` | 8 pt 来源文字，不用于承载主要结论 |
| `\PCLPlaceholder[高度]{说明}` | 占位图框，正式报告中应替换 |
| `\PCLTitleColor{颜色}` | 修改后续正文标题颜色 |
| `\PCLSetAssetPath{目录/}` | 改变素材目录，末尾保留斜杠 |
| `\PCLClosingFrame[结束语]` | 结束页 |

建议按内容选择组件。单图结果页、照片页可直接使用白底无框布局，不必同时加入顶部说明条、蓝色卡片和底部结论条。原有卡片版式保留，适合确实需要分组的内容。

默认标题 16 pt、正文 11 pt。当前画布比传统 PPT 的物理尺寸小，应按实际投影效果判断字号，不能直接比较两种文件的 pt 数值。图表内文字也应保持可读，正文不会自动缩小以适应过多内容。

## 科研图表

导言区加载 `\usepackage{pclplots}`，即可使用：

- `pcl axis`：统一坐标轴、单位标签、网格、图例和字号。
- `pcl method`：蓝色实线、圆形标记，用于主要方法。
- `pcl baseline`：灰色虚线、方形标记，用于基线。
- `pcl reference`：赭色点划线、三角形标记，用于理论或参考曲线。

```latex
\begin{tikzpicture}
  \begin{axis}[pcl axis,width=120mm,height=46mm,
      xlabel={信噪比 / dB},ylabel={归一化误差}]
    \addplot[pcl method] coordinates {(0,0.8)(10,0.3)(20,0.1)};
    \addlegendentry{方法 A}
  \end{axis}
\end{tikzpicture}
```

颜色、线型和标记同时区分方法，降低投影色差的影响。所有示例数据均为排版演示；正式报告必须换成经过核实的数据和准确的标签。同一方法在不同页面保持同一种样式，坐标轴注明单位，比较时明确实验条件。

`demo.tex` 中还提供了原生 TikZ 系统框图、无框双图页、照片加说明页。示例照片为实验室楼宇，不代表实验平台。可直接复制相应 `frame` 并替换内容。

## 编号、素材与交付

页码默认使用 Beamer 的帧编号。封面计数但不显示，目录计数并显示，结束页不显示；动画的多个叠加步骤共享同一帧编号。自动目录分页会增加帧数。

所有页面只引用 `assets/logo-cover.jpg`。其他旧 Logo 文件是保留的源素材，不参与渲染。封面蓝色渐变、目录楼宇照片、正文左上装饰和结束页地图背景均沿用现有视觉语言。

正式交付前编译 PDF，检查全部页面、实际曲线的文字、长图注和交叉引用；成功编译本身不保证没有视觉问题。普通正文内容过多仍可能产生 `Overfull` 警告，应精简或拆页。固定高度卡片应按实际内容检查。
