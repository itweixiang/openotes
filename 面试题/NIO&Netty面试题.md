- BIO、NIO、AIO有什么区别？

  BIO为Blocking IO，一条连接需要启动一个线程进行处理

  NIO为Not Blocking IO，同步非阻塞IO，将网络连接虚拟化成Channel，通过Selector获取对应状态的Channel进行操作

  AIO为Async Not Blocking IO，异步非阻塞IO，为NIO的2.0版本，在NIO的基础上增加了异步回调的功能

  

- socket、selector、channel、buffer的关系是怎样的？

  - socket，网络层TCP和UDP连接的对象
  - channel，网络
  - selector，多路复用器
  - buffer，



- buffer的flip()、rewind()方法的作用是什么？

  flip切换到读模式，将缓冲区的position指针指向数据的第一位，limit指针指向数据的最后一位

  rewind将缓冲区的position指针指向数据的第一位

  

- channel的操作有哪些？

  可读、可写、连接、接收。

  channel并不是可以支持所有的操作，例如客户端的SocketChannel就不支持Accept

  

- NIO如何处理黏包和半包？

  对于黏包，依次读取包中的数据，确定分隔符的位置，然后切割即可

  对于半包，使用compact()方法，将尾部数据压缩到头部，后续再写入时就自动连在一起了



- NIO的空轮询怎么处理？

  JDK1.5引入了epoll来优化NIO，epoll机制将事件处理交给了操作系统内核，优化了select和poll文件描述符无效遍历的问题。但是在Java的实现存在bug，即使客户端无数据新数据处理时，多路复用器的select()方法仍有可能被唤醒，如果外层存在while true，则会导致不断空转，CPU使用率100%。

  Netty用一个变量记录空转的次数，如果达到512，则重新创建一个多路复用器。

  

- NIO和Netty有什么区别？

  原生的NIO，解决了网络层的通信问题，但是API过于低效和难用，需要自己构建协议，甚至select方法还有bug。

  Netty基于NIO开发，API比较容易上手，有HTTP等基础协议的支持，重新开发了FastThreadLocal，解决了select的bug。

  

- 什么是reactor模式？

  

- EventLoop和EventLoopGroup的区别是什么？

  EventLoop是单线程的执行器，在run方法中处理channel中的事件。

  EventLoopGroup是一组EventLoop，channel调用EventLoopGroup的register()方法，与一个EventLoop进行绑定，后续该channel的操作有绑定的EventLoop进行处理。

  

- Boss Group、Worker Group、Default Group有什么区别？

  都是EventLoopGroup实例。

  Boss只处理ServerSocketChannel上的Accept事件，Worker处理SocketChannel的读写事件。

  Default Group不处理IO事件，只处理普通的业务逻辑。

  

- Boss Group如何实现多线程效果？

  如果只监听一个端口，那么服务端的ServerSocketChannel只会与Boss Group中的一个EventLoop进行绑定，无法实现多线程效果，但是boss只处理Accept，不大会产生性能瓶颈。

  Boss Group的多线程，适用于服务端监听多个端口的情况。

  

- PipeLine不同处理过程如何实现EventLoop的切换？

  Netty源码中，会判断下一个处理的线程和当前线程是否是同一个，如果是同一个，则直接执行。如果不是，则传递给下一个EventLoop。

  

- Netty为什么需要先调用sync()的方法？

  sync()是ChannelFuture的方法，ChannelFuture由Bootstrap的connect()方法获得，而connect()方法是异步非阻塞的。

  所以获取到ChannelFuture之后，不一定意味着连接已经建立，往未建立好的连接发消息，是发不出去的。

  所以一般会调用sync()阻塞当前线程，直到连接建立。

  

- Netty可不可以不调用sync()的方法？

  可以，往ChannelFuture中添加一个Listener，监听回调的结果，在回调成功后，再往channel发消息。

  

- Netty如何优雅的关闭？

  Channel的close()方法，是异步非阻塞的。所以一般需要通过channel获取CloseFuture，然后在sync()方法后，执行EvenLoopGroup的优雅关闭方法。

  或者是在CloseFuture添加个Listener，在Listener中执行关闭代码。

  如果是整个程序的关闭，需要使用Runtime中优雅关闭的钩子方法，在其中关闭相关资源。

  

- JDK Future和Netty Future有什么区别？

  JDK Future只能同步等待任务结束才能通过get()得到结果，不能区分任务成功还是失败

  Netty Future继承自JDK Future，可以get()同步获取结果，也可以getNow()异步获取结果，也可以添加Listener，在Listener中执行回调，并且可以通过isSuccess()判断任务是否成功

  Netty还提供了Promise，继承自Netty Future，脱离了任务独立存在，使用上更灵活，可以作为两个线程传递的容器

  

- Pipeline是什么？

  Netty通过ChannelHandler来处理Channel上的各种事件，所有的ChannelHandler连在一起就是Pipeline

  

- Netty有哪些常用的Handler？

  InBoundHandler，用来处理入站的数据。OutBoundHandler，用来处理出站的数据。EmbeddedHandler，用来测试。

  

- Netty如何实现监听多个端口？

  在BootstrapServer中，直接绑定即可，但是获得的ChannelFuture不一样，需要分别处理
  
  
  
- Netty如何进行调优？

  - boss group和worker group分开，避免阻塞accept事件
  - 使用default group处理具体的业务操作，不占用worker group的线程资源，避免io阻塞

  

- Netty中的ByteBuf对比NIO的ByteBuffer有什么区别？

  NIO的ByteBuffer读取时，要先flip()，非常麻烦。Netty的ByteBuf底层分别记录读写指针，不需要flip()

  NIO的ByteBuffer的容量是固定的，Netty的ByteBuf有初始容量和最大容量，可以动态扩容，更节约内存

  

- Netty如何池化内存？

  4.1版本后的Netty默认开启池化

  

- Netty的ByteBuf需要手动释放吗？

  

- Netty为什么会出现黏包和半包？

  UDP的情况下不会出现黏包和半包。

  Netty中出现黏包的原因，一是ByteBuf设置太大，存储了多个报文。二是TCP本来就有滑动窗口，接收方处理不及时，滑动窗口就可能缓存了多个报文。另外Nagle算法也会产生黏包。

  半包的原因是，ByteBuf设置太小（默认是1024字节），数据就会被切割发送。二是滑动窗口的缓冲区不足，数据也会被切割。此外MSS还有限制，超过MSS限制就会被切割发送，造成半包。

  

- Netty如何处理黏包和半包？

  每次发完消息就关闭Netty的连接，改成短连接，就不会有黏包了，但是没办法解决半包。

  Netty也提供了一个定长解码器，但是需要服务器和客户端都约定好一个固定的数据长度。客户端在数据长度不够时，需要手动填充，服务端需要处理填充的数据。

  Netty还提供了一个行解码器，通过识别\r\n作为分隔符，自动处理黏包和半包。但是需要一个字节一个字节解析，效率比较低。

  Netty中一般使用LTC解码器，来处理黏包和半包。在报文增加一个长度，服务端在解析数据时获取这个长度，就能够正确解析数据。

  

- LTC解析器构造参数的含义是什么？

  最大帧长度、长度的偏移量、长度占用的字节、长度和内容之间的还有多少字节、解析剥离的字节

  

- 如何使用Netty模拟Redis客户端？

  根据Redis的RESP协议，连接Redis，然后根据协议规则，往Redis发数据即可

  

- 如何使用Netty模拟Http服务端？

  Netty提供了Http协议的解码器，直接添加该解码器，然后在Http解码器的后自定一个自己的handler，就可以处理http协议的内容了

  

- 自定义传输协议有哪些要素？

  魔数，如cafebabe，用来判断是否有效数据包

  版本号，序列化算法、指令类型、请求序号、请求头、正文长度、消息正文

  

- IO多路复用如何支持海量连接？

  在操作系统层面，使用epoll函数，减少用户空间和内核空间的数据拷贝，减少网络连接的文件描述符遍历次数。

  在Java层面，使用NIO或者Netty减少网络连接的对应的线程数，减少操作系统的资源开销

  

- 如何正确的关闭Socket？

  // todo 

  

- 为什么图片、视频、音乐、文件等 都是要字节流来读取？

  怎么存的就怎么读，用字节流来存储就用字节流读



-  select()、poll、epoll()方法有什么区别？

  // todo 



