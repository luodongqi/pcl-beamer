# 鹏城实验室 Beamer 模板

鹏城实验室蓝白风格 Beamer 模板，采用 XeLaTeX 编译，提供主题、空白入口和通用版式示例。

## 文件

| 文件 | 用途 |
| --- | --- |
| `beamerthemePCL.sty` | 主题、字体、配色、封面、目录、章节页、页码和正文组件 |
| `main.tex` | 正式写作入口，目前只有占位封面和结束页 |
| `demo.tex` | 10 页通用版式示例，没有科研结论或实验数据 |
| `demo.pdf` | 已编译的版式预览 |
| `main.pdf` | 空白入口编译结果 |
| `assets/` | 从原 PPT 提取的徽标、楼宇照片与结束页背景 |
| `build.ps1` | Windows 编译脚本，自动运行两遍 XeLaTeX |
| `latexmkrc` | 可选的 latexmk 配置 |

## 编译

在此文件夹打开 PowerShell：

```powershell
.\build.ps1 -Target demo
.\build.ps1 -Target main
```

脚本将辅助文件放入上一级目录的 `tmp/pcl_beamer-build/`，并把完成的 PDF 复制到当前目录。需要 TeX Live 及其 Beamer、ctex、TikZ、tcolorbox 等常用宏包。已在本机 TeX Live 2025 下验证。

也可使用 `latexmk -xelatex main.tex`（PDF 和辅助文件位于 `../tmp/pcl_beamer-build/`）。目录和章节引用需要至少编译两遍。必须从模板文件夹编译，以正确读取本地主题和 `assets/`。

中文优先使用微软雅黑及其粗体，未安装时回退到 TeX Live 的 Fandol 黑体。西文优先使用 Arial，回退到 TeX Gyre Heros。字体文件没有随模板分发。预览 PDF 已嵌入所用字体。

## 开始写作

修改 `main.tex` 的 `\title`、`\subtitle`、`\author`、`\institute`、`\date`。标题支持用 `\\` 分成两行。建议封面主标题最多两行，副标题最多一行。

封面日期默认使用 `\date{\PCLCurrentYearMonth}`，自动显示编译时的当前年月；需要固定日期时可自行覆盖 `\date{...}`。

```latex
\PCLTitleFrame
\PCLContentsFrame
\PCLSectionFramesOn

\section{章节名称}
\begin{frame}{页面标题}
  \PCLLead[要点]{本页问题或方法概述。}
  % 插入正文、图片、公式或 columns。
  \vfill
  \PCLTakeaway{一句话概括本页结论。}
\end{frame}

\PCLClosingFrame
```

`\PCLSectionFramesOn` 在每个 `\section` 前自动插入章节目录，当前章节红色，其他章节蓝色。`\PCLSectionFramesOff` 关闭自动插入。也可以不启用自动模式，只在需要处调用 `\PCLSectionFrame`。不要同时自动和手动插入同一章节页。

当前章节统一使用 `#C00000`。`\PCLContentsFrame` 在正文开始前显示全蓝总目录；在章节中调用时，同样将当前章节标红。

目录建议容纳 3–5 个一级章节，每个名称保持一行。章节较多时，应拆分目录或调整主题中的目录字体与行距。主题不自动缩小正文，也不自动压缩过长标题。

## 组件

| 命令或环境 | 功能 |
| --- | --- |
| `\PCLTitleFrame` | 原模板风格封面 |
| `\PCLContentsFrame` | 总目录 |
| `\PCLSectionFrame` | 当前章节高亮的目录页 |
| `\PCLLead[标签]{说明}` | 浅蓝色顶部说明条 |
| `\begin{PCLPanel}[可选参数]{标题} ... \end{PCLPanel}` | 蓝色标题栏的正文卡片；参数沿用 tcolorbox |
| `\PCLTakeaway{结论}` | 蓝底白字结论条 |
| `\PCLSource{来源或图注}` | 小号灰色来源或图注 |
| `\PCLPlaceholder[高度]{占位说明}` | 临时图片占位框，默认 36 mm 高 |
| `\PCLImage[最大宽度]{最大高度}{图片路径}` | 保持宽高比的居中图片 |
| `\PCLClosingFrame[结束语]` | 原模板风格结束页 |
| `\PCLTitleColor{PCLBlue}` | 将后续正文标题改为蓝色；默认深红色 |
| `\PCLSetAssetPath{目录/}` | 修改素材目录，末尾保留斜杠 |

标准 Beamer 的 `frame`、`columns`、`block`、`alertblock`、`itemize`、公式和表格可直接使用。较多内容的页面建议 `\begin{frame}[t]{标题}` 顶部对齐。

## 与原模板的对应关系

- 保留 16:9 比例，使用 160 × 90 mm 的 Beamer 画布，所有装饰按源文件坐标等比例放置。
- 封面保留蓝色纵向渐变、跨越色带边界的圆形徽标、蓝色居中标题和底部汇报信息。为两行标题和可选副标题调整了少量信息间距。
- 正文保留左上角蓝色方块渐变装饰、右上角徽标、深红色标题及右下角页码。标题起点为距页面左边缘 20.8 mm，与装饰留出间隔。原模板也有蓝色标题，提供切换命令。
- 目录保留左侧楼宇照片、几何裁切、上方 CONTENTS、右下角蓝色装饰和当前章节红色高亮。复杂自由曲线简化为 TikZ 多边形，照片保持宽高比。
- 原模板正文中的浅蓝说明框和蓝色结论条改为可扩展组件；复杂竖排标签和嵌套框改为卡片、双栏或三栏。
- 结束页复用原 PPT 的地图渐变背景，统一采用封面徽标，保留左下方致谢文字。徽标圆形裁切以避免白色方形边角。
- 正文文字、公式、表格、几何装饰均为 LaTeX 原生对象，未将整页 PPT 栅格化作为正文背景。

所有页面统一引用封面的 `assets/logo-cover.jpg`（“鹏城实验室”）。`assets/` 中原有的其他徽标素材仅保留作为源素材，不再被主题引用。

## 使用尺寸与注意事项

- 页面可用正文宽度约 149 mm；正文上下空间取决于标题、页脚和组件数量。
- 默认标题 16 pt、正文 11 pt，按 160 mm 页面宽度缩放后适合投影。来源文字 7 pt，仅用于辅助信息。
- 正文标题建议一行，不宜超过约 22 个全角字符；较长标题可用较短措辞或单页局部调整字号。
- 单大图模板使用约 40 mm 高图区；无说明条、无结论条时可放大。
- 图片优先用 PDF 矢量文件或高分辨率 PNG。
- 所有框的高度以内容为准；固定高度卡片应由作者检查内容是否溢出。
- 页码沿用原 PPT 的页序口径：封面计数但不显示，目录显示为第 2 页，结束页不显示。需要自定义时修改 `\PCLPageNumber`。
- 仅将 `.sty`、`.tex`、`assets/` 和必要的构建文件复制到新项目即可使用，不依赖本机的绝对路径。

## 验证

已编译 `demo.tex` 并检查 10 页版式。预览中的内容全部是模板说明或占位文字，不代表真实实验结果。
