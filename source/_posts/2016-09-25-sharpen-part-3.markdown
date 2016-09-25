---
layout: post
title: "Sharpen - Part 3"
date: 2016-09-25 13:12:19 -0700
comments: true
categories: 
- c#
- sharpen
- mono
- java
- os-x
---

##Sharpen

Part 1: [The correct Java version](http://sushihangover.github.io/sharpen/)

Part 2: [Building Sharpen](http://sushihangover.github.io/sharpen-part-2/)

###Sharpen Support Classes:

Converting your Java classes using the default config from [ydanila](https://github.com/ydanila) you might want to look at the Sharpen support classes from [`ngit`](https://github.com/mono/ngit):

* https://github.com/mono/ngit/tree/master/Sharpen

* https://github.com/mono/ngit/tree/master/Sharpen.Unix

###Type.FullName:

	Sharpen.AccessController
	Sharpen.AList`1
	Sharpen.Arrays
	Sharpen.AtomicInteger
	Sharpen.AtomicLong
	Sharpen.AtomicReference`1
	Sharpen.AtomicReferenceArray`1
	Sharpen.BufferedInputStream
	Sharpen.BufferedOutputStream
	Sharpen.BufferedReader
	Sharpen.ByteArrayInputStream
	Sharpen.ByteArrayOutputStream
	Sharpen.Callable`1
	Sharpen.CharBuffer
	Sharpen.CharsetDecoder
	Sharpen.CharsetEncoder
	Sharpen.CodingErrorAction
	Sharpen.Collections`1
	Sharpen.Collections
	Sharpen.ConcurrentHashMap`2
	Sharpen.ConcurrentMap`2
	Sharpen.CopyOnWriteArrayList`1
	Sharpen.CountDownLatch
	Sharpen.CRC32
	Sharpen.CyclicBarrier
	Sharpen.DataConverter
	Sharpen.DataConverter+PackContext
	Sharpen.DataConverter+CopyConverter
	Sharpen.DataConverter+SwapConverter
	Sharpen.DeflaterOutputStream
	Sharpen.EnumerableWrapper`1
	Sharpen.EnumeratorWrapper`1
	Sharpen.Executors
	Sharpen.FixedThreadPoolExecutorService
	Sharpen.FutureBase
	Sharpen.TaskFuture`1
	Sharpen.CancellationException
	Sharpen.RejectedExecutionException
	Sharpen.ExecutorService
	Sharpen.Extensions
	Sharpen.FileChannel
	Sharpen.FileChannel+MapMode
	Sharpen.FileInputStream
	Sharpen.FileLock
	Sharpen.FileOutputStream
	Sharpen.FileReader
	Sharpen.FileWriter
	Sharpen.Future`1
	Sharpen.GZIPInputStream
	Sharpen.GZIPOutputStream
	Sharpen.InflaterInputStream
	Sharpen.InheritableThreadLocal`1
	Sharpen.InputStreamReader
	Sharpen.LinkageError
	Sharpen.LinkedHashMap`2
	Sharpen.ListIterator`1
	Sharpen.MappedByteBuffer
	Sharpen.Matcher
	Sharpen.MessageFormat
	Sharpen.ObjectInputStream
	Sharpen.ObjectOutputStream
	Sharpen.OutputStreamWriter
	Sharpen.Pattern
	Sharpen.PipedInputStream
	Sharpen.PipedOutputStream
	Sharpen.PrintWriter
	Sharpen.PrivilegedAction`1
	Sharpen.RandomAccessFile
	Sharpen.ReentrantLock
	Sharpen.Reference`1
	Sharpen.ReferenceQueue`1
	Sharpen.Runtime
	Sharpen.Runtime+ShutdownHook
	Sharpen.SimpleDateFormat
	Sharpen.SingletonList
	Sharpen.SoftReference`1
	Sharpen.SynchronizedList`1
	Sharpen.Thread
	Sharpen.ThreadGroup
	Sharpen.TimeUnit
	Sharpen.TimeUnitExtensions
	Sharpen.WrappedSystemStream
	Sharpen.AbstractCollection`1
	Sharpen.AbstractList`1
	Sharpen.AbstractList`1+SimpleIterator
	Sharpen.AbstractMap`2
	Sharpen.AbstractSet`1
	Sharpen.Authenticator
	Sharpen.ByteBuffer
	Sharpen.ByteOrder
	Sharpen.CharSequence
	Sharpen.StringCharSequence
	Sharpen.DigestOutputStream
	Sharpen.EnumSet
	Sharpen.EnumSet`1
	Sharpen.VirtualMachineError
	Sharpen.StackOverflowError
	Sharpen.BrokenBarrierException
	Sharpen.BufferUnderflowException
	Sharpen.CharacterCodingException
	Sharpen.DataFormatException
	Sharpen.EOFException
	Sharpen.Error
	Sharpen.ExecutionException
	Sharpen.InstantiationException
	Sharpen.InterruptedIOException
	Sharpen.MissingResourceException
	Sharpen.NoSuchAlgorithmException
	Sharpen.NoSuchElementException
	Sharpen.NoSuchMethodException
	Sharpen.OverlappingFileLockException
	Sharpen.ParseException
	Sharpen.RuntimeException
	Sharpen.StringIndexOutOfBoundsException
	Sharpen.UnknownHostException
	Sharpen.UnsupportedEncodingException
	Sharpen.URISyntaxException
	Sharpen.ZipException
	Sharpen.GitException
	Sharpen.ConnectException
	Sharpen.KeyManagementException
	Sharpen.IllegalCharsetNameException
	Sharpen.UnsupportedCharsetException
	Sharpen.Executor
	Sharpen.FilenameFilter
	Sharpen.FilePath
	Sharpen.FilterInputStream
	Sharpen.FilterOutputStream
	Sharpen.InputStream
	Sharpen.Iterable`1
	Sharpen.Iterator
	Sharpen.Iterator`1
	Sharpen.MessageDigest
	Sharpen.MessageDigest`1
	Sharpen.OutputStream
	Sharpen.PasswordAuthentication
	Sharpen.ResourceBundle
	Sharpen.Runnable
	Sharpen.TreeSet`1
	Sharpen.LinkedHashSet`1
	Sharpen.ProxySelector
	Sharpen.Proxy
	Sharpen.URLConnection
	Sharpen.HttpsURLConnection
	Sharpen.HttpURLConnection
	Sharpen.URLEncoder
	Sharpen.BitSet
	Sharpen.Channels
	Sharpen.BufferedWriter
	Sharpen.X509TrustManager
	Sharpen.X509Certificate
	Sharpen.TrustManager
	Sharpen.SSLContext
	Sharpen.AtomicBoolean
	Sharpen.ScheduledThreadPoolExecutor
	Sharpen.ScheduledThreadPoolExecutor+Task`1
	Sharpen.IScheduledITask
	Sharpen.Scheduler
	Sharpen.ThreadFactory
	Sharpen.ThreadPoolExecutor
	Sharpen.RunnableAction
	Sharpen.JavaWeakReference`1
	Sharpen.SystemProcess
	Sharpen.DateFormat
	Sharpen.DigestInputStream
	Sharpen.FileHelper
	Sharpen.JavaCalendar
	Sharpen.JavaGregorianCalendar
	<PrivateImplementationDetails>
	<PrivateImplementationDetails>+$ArrayType=1024
	Sharpen.FixedThreadPoolExecutorService+<Submit>c__AnonStorey0`1
	Sharpen.Extensions+<ContainsAll>c__AnonStorey0`2
	Sharpen.Extensions+<Contains>c__AnonStorey1`1
	Sharpen.LinkedHashMap`2+<Put>c__AnonStorey0
	Sharpen.LinkedHashMap`2+<Remove>c__AnonStorey1
	Sharpen.AbstractMap`2+<ContainsKey>c__AnonStorey0
	Sharpen.AbstractMap`2+<Get>c__AnonStorey1
	Sharpen.Scheduler+<HasTasks>c__AnonStorey0
	
###Via: 
	
	Assembly assembly = Assembly.ReflectionOnlyLoad("Sharpen");
	foreach (Type type in assembly.GetTypes())
	{
	   Console.WriteLine(type.FullName);
	}
			
