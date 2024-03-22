# tmux
## tmux是什么
Tmux（Terminal mutiplexer）是一个终端多路复用器。要理解tmux首先要理解终端的概念，终端最初的定义是一台电脑或计算机系统，用来让用户输入数据，及显示其计算结果的机器。随着计算机技术的不断发展，终端被泛指人与机器交互的接口，负责信息的输入和输出。本文中所提到的终端更多的聚焦在图形终端上。大家熟悉的图形终端如常见GUI（图形用户界面），典型的有windows操作系统上桌面和窗口，可以在桌面上打开一个应用程序的窗口进行信息交互。其次是理解多路复用的概念，GUI管理了显示器上的二维空间，有个问题是如果一个应用程序占满了显示器上的二维空间，同时用户又想进行一些其他的交互，此时就会发生冲突，解决这个冲突一个方法就是多路复用（多路复用这个概念被用在很多的地方）。对图形交互界面而言，分屏和虚拟桌面是多路复用的实现方式，分屏是解决如何高效利用显示空间的问题，通过分屏我们可以将多个相关应用排列在同一个显示空间里进行工作。分屏也存在一定的瑕疵，比如当我们打开vscode进行编码，又要发微信消息，可以通过分屏来实现，但是这时专注代码的能力下降了，虚拟桌面解决的是如何有效隔离多种使用场景的问题，虚拟桌面是在物理桌面空间上“虚拟”出多个互不相干的桌面空间，每个桌面空间内都可以有自己的窗口布局。虽然同时只能使用一个虚拟桌面，但我们可以在多个虚拟桌面间快速切换。使用虚拟桌面 后，我们可以将比较相关的一类程序的窗口放在同一个虚拟桌面中，其余不相干的程序则放在其他虚拟桌面中，如此，可以有效减少其他程序对于当前工作任务的干扰，同时又能在多种不同工作环境中快速切换。
## tmux的核心概念
tmux中有3个核心概念：会话（session）、窗口（windows）和窗格（pane）。类比大家熟悉的GUI，窗口对标的概念是GUI桌面，窗格对标的GUI窗口。会话如何理解呢，会话可以类比成一个图形显示器，可以容纳若干个窗口是窗口组的集合。
## tmux安装及使用
部分操作系统已提前在内部预置tmux，用户可直接使用。如果系统内没有预置则需要手动安装，针对Ubuntu系统安装命令如下：
```
sudo apt install tmux
```
其余linux系统操作系统可通过其对应的包管理工具安装。
## tmux常用命令及快捷键
说明：所有用<>（尖括号）中的内容都可以根据自己的需要来替换。
### session管理常用命令
管理session主要是在shell中对进行，所以主要以命令为主，部分没有快捷键。
- 创建新session: tmux new -s &lt;session-name&gt;；
- 列出所有session: tmux list-session/tmux ls；
- 连接到一个已存在的session: tmux attach -t session-name/tmux a，tmux a命令将默认连接到上一个使用的session；
- 离开当前session: 在session内使用&lt;prefix&gt; + d快捷键；
- 终止某个session: tmux kill-session -t &lt;session-name&gt;；

### 窗口及窗格快捷键
tmux的快捷键使用前缀+快捷键（&lt;prefix&gt; + key）的方式，默认的前缀是ctrl+b，使用快捷键时首先要按下前缀然后按下相应的快捷键。
#### 窗口管理快捷键
- 创建新窗口：&lt;prefix&gt; + c；

- 关闭当前窗口：&lt;prefix&gt; + &；

- 切换至指定窗口：&lt;prefix&gt; + 数字键；

- 切换至上一窗口：&lt;prefix&gt; + p；

- 切换至下一窗口：&lt;prefix&gt; + n；

- 在前后两个窗口间互相切换：&lt;prefix&gt; + l；

- 通过窗口列表切换窗口：&lt;prefix&gt; + w

- 重命名当前窗口：&lt;prefix&gt; + ,；

- 修改当前窗口编号，相当于窗口重新排序：&lt;prefix&gt; + .；

- 在所有窗口中查找指定文本：&lt;prefix&gt; + f：

#### 窗格管理常用快捷键
- 将当前面板平分为上下两块：&lt;prefix&gt; + ”；

- 将当前面板平分为左右两块：&lt;prefix&gt; + %；

- 关闭当前面板：&lt;prefix&gt; + x；

- 将当前面板置于新窗口，即新建一个窗口，其中仅包含当前面板：&lt;prefix&gt; + !；

- 以1个单元格为单位移动边缘以调整当前面板大小：&lt;prefix&gt; + Ctrl+方向键：

- 以5个单元格为单位移动边缘以调整当前面板大小：&lt;prefix&gt; + Alt+方向键：

- 在预置的面板布局中循环切换；依次包括even-horizontal、even-vertical、main-horizontal、main-vertical、tiled：&lt;prefix&gt; + Space；

- 显示面板编号：&lt;prefix&gt; + q；

- 在当前窗口中选择下一面板：&lt;prefix&gt; + o；

- 移动光标以选择面板：&lt;prefix&gt; + 方向键；

- 向前置换当前面板：&lt;prefix&gt; + {；

- 向后置换当前面板：&lt;prefix&gt; + }；

## tmux配置与自定义
tmux支持高度自定义的配置，且有丰富的插件生态。可通过修改～/.tmux.conf文件中的选项来自定义tmux，同时可以直接使用别人的配置。

## 扩展阅读
tmux手册：http://man.openbsd.org/OpenBSD-current/man1/tmux.1

tmux配置：https://github.com/gpakosz/.tmux

tmux相关资源列表：https://github.com/rothgar/awesome-tmux