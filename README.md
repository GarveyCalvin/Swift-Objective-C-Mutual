# Swift-Objective-C-Mutual
Swift &amp; Objective-C Mutual

主要讲述 Swift 和 Objective-C 的交互方法，里面附带有两个项目：
SwiftCallObject-C：Swift 调用 Objective-C
Object_CCallSwift：Objective-C 调用 Swift

希望对大家有所帮助，谢谢！

#Swift 与 Object-C 交互 （Swift版本为：1.2）
<p>博文作者：GarveyCalvin</p>
<p>博文首发：<a href="http://www.cnblogs.com/GarveyCalvin/" target="_blank">http://www.cnblogs.com/GarveyCalvin/</a></p>
<br><br><br>

<p>这篇文章主要是介绍 Swift 与 Object-C 之间进行交互的代码，主要分为两个部分。一个是 Swift 项目调用 Object-C 的类，另一个是 Object-C 项目调用 Swift 类。过程是很简单，但是对于没接触过的人来说，还是存在一点难度的。</p>
<p>&nbsp;</p>
<p>你可以在 GitHub 上下载此文章相关的源代码：<a href="https://github.com/GarveyCalvin/Swift-Objective-C-Mutual" target="_blank">Swift-Objective-C-Mutual</a>（https://github.com/GarveyCalvin/Swift-Objective-C-Mutual）</p>
<p>&nbsp;</p>
<p><span style="font-size: 16px;"><strong>一、Swift 调用 Object-C</strong></span></p>
<p>现在来说说正题吧，目的是&ldquo;使用 Swift 调用 Object-C&rdquo; ，那么我们先来准备一下。我们需要验证以下问题：</p>
<p>1.如何调用 Object-C 的类方法;</p>
<p>2.如何调用 Object-C 的实例方法;</p>
<p>3.如何访问&nbsp;Object-C 的属性</p>
<p>&nbsp;</p>
<p>我们新建一个 Swift 项目，项目新建完成后，添加 Person 类，添加的语言为 Object-C 。</p>
<p><img src="http://images0.cnblogs.com/blog2015/684349/201505/142209348767608.png" alt="" width="590" height="343" /></p>
<p>&nbsp;</p>
<p>点击 Next 后会有一个弹窗，询问你是否需要建立一个桥接，就是与 Object-C 连接的一个桥梁。它会帮我们建立一个头文件，命名方式为&ldquo;项目名称-Bridging-Header.h&rdquo;，当然这里我们选 Yes。</p>
<p><img src="http://images0.cnblogs.com/blog2015/684349/201505/142210367829962.png" alt="" width="371" height="144" /></p>
<p>&nbsp;</p>
<p>我们的结构目录变成这样，我这里新建的桥接文件名为&ldquo;SwiftCallObject-C-Bridging-Header.h&rdquo;。</p>
<p><img src="http://images0.cnblogs.com/blog2015/684349/201505/142213001424298.png" alt="" width="229" height="224" /></p>
<p>&nbsp;</p>
<p>这个文件建好以后，是没有自动帮我们导入头文件的，因此我们需要导入需要被调用的 Object-C 类头文件，这样我们的&nbsp;Swift 才能正确地调用 Object-C。</p>
<div class="cnblogs_code">
<pre><span style="color: #008000;">//</span>
<span style="color: #008000;">//</span><span style="color: #008000;">  Use this file to import your target's public headers that you would like to expose to Swift.
</span><span style="color: #008000;">//
</span><span style="color: #000000;">
#import </span><span style="color: #800000;">"</span><span style="color: #800000;">Person.h</span><span style="color: #800000;">"</span></pre>
</div>
<p>&nbsp;</p>
<p>&nbsp;我们来看看 Person 类的代码，这个类宝义了一个 name 的属性，和一个 print 实例方法，还有一个 personWithName: 方法，主要是示范给你们如何调用这些。先来看&nbsp;Person.h 。</p>
<div class="cnblogs_code">
<pre><span style="color: #008000;">//</span>
<span style="color: #008000;">//</span><span style="color: #008000;">  Person.h
</span><span style="color: #008000;">//</span><span style="color: #008000;">  SwiftCallObject-C
</span><span style="color: #008000;">//</span>
<span style="color: #008000;">//</span><span style="color: #008000;">  Created by baijiawei on 15/5/14.
</span><span style="color: #008000;">//</span><span style="color: #008000;">  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
</span><span style="color: #008000;">//
</span>
<span style="color: #0000ff;">#import</span> &lt;Foundation/Foundation.h&gt;

<span style="color: #0000ff;">@interface</span><span style="color: #000000;"> Person : NSObject

@property (strong, nonatomic) NSString </span>*<span style="color: #000000;">name;

</span>- (<span style="color: #0000ff;">void</span><span style="color: #000000;">)print;

</span>+ (<span style="color: #0000ff;">id</span>)personWithName:(NSString *<span style="color: #000000;">)name;

</span><span style="color: #0000ff;">@end</span></pre>
</div>
<p>&nbsp;&nbsp;</p>
<p>Person.m 。</p>
<div class="cnblogs_code">
<pre><span style="color: #008000;">//</span>
<span style="color: #008000;">//</span><span style="color: #008000;">  Person.m
</span><span style="color: #008000;">//</span><span style="color: #008000;">  SwiftCallObject-C
</span><span style="color: #008000;">//</span>
<span style="color: #008000;">//</span><span style="color: #008000;">  Created by baijiawei on 15/5/14.
</span><span style="color: #008000;">//</span><span style="color: #008000;">  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
</span><span style="color: #008000;">//
</span>
<span style="color: #0000ff;">#import</span> <span style="color: #800000;">"</span><span style="color: #800000;">Person.h</span><span style="color: #800000;">"</span>

<span style="color: #0000ff;">@implementation</span><span style="color: #000000;"> Person

</span>- (<span style="color: #0000ff;">void</span><span style="color: #000000;">)print
{
    NSLog(</span><span style="color: #800000;">@"</span><span style="color: #800000;">name is %@</span><span style="color: #800000;">"</span><span style="color: #000000;">, self.name);
}

</span>+ (<span style="color: #0000ff;">id</span>)personWithName:(NSString *<span style="color: #000000;">)name
{
    Person </span>*person =<span style="color: #000000;"> [[Person alloc] init];
    person.name </span>=<span style="color: #000000;"> name;
    </span><span style="color: #0000ff;">return</span><span style="color: #000000;"> person;
}

</span><span style="color: #0000ff;">@end</span></pre>
</div>
<p>&nbsp;&nbsp;</p>
<p>调用方法如下。</p>
<div class="cnblogs_code">
<pre>var person = Person() <span style="color: #008000;">//</span><span style="color: #008000;"> 实例化对象</span>
person.name = <span style="color: #800000;">"</span><span style="color: #800000;">Garvey</span><span style="color: #800000;">"</span> <span style="color: #008000;">//</span><span style="color: #008000;"> 访问对象属性</span>
person.print() <span style="color: #008000;">//</span><span style="color: #008000;"> 调用对象方法</span>
<span style="color: #000000;">
var personC </span>= Person.personWithName(<span style="color: #800000;">"</span><span style="color: #800000;">Calvin</span><span style="color: #800000;">"</span>) <span style="color: #0000ff;">as</span>! Person <span style="color: #008000;">//</span><span style="color: #008000;"> 调用 Person 的类方法，返回一个它的实例</span>
personC.print() <span style="color: #008000;">//</span><span style="color: #008000;"> 调用对象方法</span></pre>
</div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><span style="font-size: 16px;"><strong>二、<strong>Object-C</strong> 调用 Swift</strong></span></p>
<p>同样的，我们需要创建一个 Object-C 的项目，然后创建 Swift 的类。我们先来创建 Person 类。</p>
<p><img src="http://images0.cnblogs.com/blog2015/684349/201505/172209299026537.png" alt="" width="525" height="305" /></p>
<p>&nbsp;</p>
<p>如果你是第在 Object-C 项目里第一次创建 Swift 的类，那么依旧会有窗口提示，询问你是否需要创建桥接文件。然而这里有一个问题，如果你选择 NO ，意思就是不创建桥接文件，那么它将不会默认帮你生成对应的调用代码; 如果你选择 Yes， 那么它将默认帮你生成对应的调用代码。那么具体是什么意思呢？。</p>
<p>&nbsp;</p>
<p>现在先来看一下 Person 类的代码，很简单，只有一个方法和一个属性。</p>
<div class="cnblogs_code">
<pre><span style="color: #008000;">//</span>
<span style="color: #008000;">//</span><span style="color: #008000;">  Person.swift
</span><span style="color: #008000;">//</span><span style="color: #008000;">  Object_CCallSwift
</span><span style="color: #008000;">//</span>
<span style="color: #008000;">//</span><span style="color: #008000;">  Created by baijiawei on 15/5/17.
</span><span style="color: #008000;">//</span><span style="color: #008000;">  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
</span><span style="color: #008000;">//
</span><span style="color: #000000;">
import Cocoa

@objc </span><span style="color: #0000ff;">class</span><span style="color: #000000;"> Person: NSObject {
    var name: String</span>?<span style="color: #000000;">
    
    func print() {
        println(</span><span style="color: #800000;">"</span><span style="color: #800000;">person name is \(name)</span><span style="color: #800000;">"</span><span style="color: #000000;">)
    }
}</span></pre>
</div>
<p>注意：Object-C 代用的 Swift 代码，Swift 类在 class 前需要添加关键字@&ldquo;@objc&rdquo;，否则，Xcode将不会为你维护头文件。</p>
<p>&nbsp;</p>
<p>这里先说明一下，在 Object-C 中调用 Swift 时，Xcode 会帮助我们自动生成头文件，不需要我们去维护。然而这里有一个前提，你必须创建好桥接文件，否则...。</p>
<p>&nbsp;</p>
<p>当我们需要使用时，引入的文件名为&ldquo;工程名称-Swift.h&rdquo;。</p>
<div class="cnblogs_code">
<pre><span style="color: #0000ff;">#import</span> <span style="color: #800000;">"</span><span style="color: #800000;">Object_CCallSwift-Swift.h</span><span style="color: #800000;">"</span></pre>
</div>
<p>&nbsp;</p>
<p>引入后我们就可以点击头文件，刚刚提及过头文件几次了，现在我们来看看头文件的代码，只截取关键部分。</p>
<p><img src="http://images0.cnblogs.com/blog2015/684349/201505/172230001867095.png" alt="" width="585" height="213" /></p>
<p>我们可以看到有 Person 类的相关代码，风格是 Object-C ，应该是 Xcode 为我们转码了。谨记，在 Object-C 调用 Swift 端代码时，Swift 类的 class 前需要加&ldquo;@objc&rdquo;关键字。<span style="line-height: 1.5;">&nbsp;</span></p>
<p>&nbsp;</p>
<p><span style="font-size: 16px;"><strong>常见问题</strong></span></p>
<p><strong>引入头文件时出错</strong></p>
<p>网上的&nbsp;Object-C&nbsp;项目调用 Object-C 代码会遇到的问题，现在网上热门的文章，绝大部分都是存在错误的，只要你不够细心，你就很有可能被&ldquo;入网&rdquo;。</p>
<p>&nbsp;</p>
<p>例如是这篇文章：http://www.ituring.com.cn/tupubarticle/2687。该文章错误点，#import "工程名-swift.h"：</p>
<p><img src="http://images0.cnblogs.com/blog2015/684349/201505/162127107205419.png" alt="" width="426" height="196" /></p>
<p>错在 HelloWorld-swift.h ，其中 swift 的 开头字母 S 必须是大写的！我就是因为这个原因，找了好久都没发现到，也是因为太过于相信网上的文章缘故吧（这里我不是在怪作者）。或许是 Xcode 更新后或是 Swift 语言更新后所作的改动吧，所以才会导致这个原因。</p>
<p>&nbsp;</p>
<p>有一个办法可以确认你的桥接文件全称，在项目的设置里可以看到：</p>
<p><img src="http://images0.cnblogs.com/blog2015/684349/201505/162130165013442.png" alt="" width="635" height="192" /></p>
<p>可以很清晰地看见，正确的写法是&ldquo;工程名-Swift.h&rdquo;，只要把这个填对了，后面的调用就简单多了。</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<hr />
