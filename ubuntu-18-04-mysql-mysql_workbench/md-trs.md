# トラシュー

- 事象

  - たいへん困った。ubuntu-19-10以外のubuntuで試す。

```
!SESSION 2020-05-04 14:39:00.254 -----------------------------------------------
eclipse.buildId=unknown
java.version=1.8.0_252
java.vendor=Private Build
BootLoader constants: OS=linux, ARCH=x86_64, WS=gtk, NL=ja_JP
Command-line arguments:  -os linux -ws gtk -arch x86_64

!ENTRY org.eclipse.osgi 4 0 2020-05-04 14:39:01.356
!MESSAGE バンドル org.eclipse.ui.ide (147) を自動的に有効化している間にエラーが発生しました。
!STACK 0
org.osgi.framework.BundleException: バンドル org.eclipse.ui.ide の org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.start() での例外。
	at org.eclipse.osgi.internal.framework.BundleContextImpl.startActivator(BundleContextImpl.java:863)
	at org.eclipse.osgi.internal.framework.BundleContextImpl.start(BundleContextImpl.java:791)
	at org.eclipse.osgi.internal.framework.EquinoxBundle.startWorker0(EquinoxBundle.java:1015)
	at org.eclipse.osgi.internal.framework.EquinoxBundle$EquinoxModule.startWorker(EquinoxBundle.java:365)
	at org.eclipse.osgi.container.Module.doStart(Module.java:603)
	at org.eclipse.osgi.container.Module.start(Module.java:467)
	at org.eclipse.osgi.framework.util.SecureAction.start(SecureAction.java:493)
	at org.eclipse.osgi.internal.hooks.EclipseLazyStarter.postFindLocalClass(EclipseLazyStarter.java:117)
	at org.eclipse.osgi.internal.loader.classpath.ClasspathManager.findLocalClass(ClasspathManager.java:571)
	at org.eclipse.osgi.internal.loader.ModuleClassLoader.findLocalClass(ModuleClassLoader.java:346)
	at org.eclipse.osgi.internal.loader.BundleLoader.findLocalClass(BundleLoader.java:398)
	at org.eclipse.osgi.internal.loader.sources.SingleSourcePackage.loadClass(SingleSourcePackage.java:41)
	at org.eclipse.osgi.internal.loader.BundleLoader.findClass(BundleLoader.java:473)
	at org.eclipse.osgi.internal.loader.ModuleClassLoader.loadClass(ModuleClassLoader.java:171)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
	at org.jkiss.dbeaver.ui.app.standalone.DBeaverApplication.setIDEWorkspace(DBeaverApplication.java:276)
	at org.jkiss.dbeaver.ui.app.standalone.DBeaverApplication.start(DBeaverApplication.java:161)
	at org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:203)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(EclipseAppLauncher.java:137)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAppLauncher.java:107)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:401)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:255)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:657)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:594)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1447)
	at org.eclipse.equinox.launcher.Main.main(Main.java:1420)
Caused by: java.lang.UnsatisfiedLinkError: Could not load SWT library. Reasons: 
	no swt-pi4-gtk-4932r18 in java.library.path
	no swt-pi4-gtk in java.library.path
	Can't load library: /home/mysql/.swt/lib/linux/x86_64/libswt-pi4-gtk-4932r18.so
	Can't load library: /home/mysql/.swt/lib/linux/x86_64/libswt-pi4-gtk.so

	at org.eclipse.swt.internal.Library.loadLibrary(Library.java:342)
	at org.eclipse.swt.internal.Library.loadLibrary(Library.java:256)
	at org.eclipse.swt.internal.gtk.OS.<clinit>(OS.java:90)
	at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:209)
	at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:155)
	at org.eclipse.swt.widgets.Display.<clinit>(Display.java:164)
	at org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.createProblemsViews(IDEWorkbenchPlugin.java:391)
	at org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.start(IDEWorkbenchPlugin.java:348)
	at org.eclipse.osgi.internal.framework.BundleContextImpl$3.run(BundleContextImpl.java:842)
	at org.eclipse.osgi.internal.framework.BundleContextImpl$3.run(BundleContextImpl.java:1)
	at java.security.AccessController.doPrivileged(Native Method)
	at org.eclipse.osgi.internal.framework.BundleContextImpl.startActivator(BundleContextImpl.java:834)
	... 29 more
Root exception:
java.lang.UnsatisfiedLinkError: Could not load SWT library. Reasons: 
	no swt-pi4-gtk-4932r18 in java.library.path
	no swt-pi4-gtk in java.library.path
	Can't load library: /home/mysql/.swt/lib/linux/x86_64/libswt-pi4-gtk-4932r18.so
	Can't load library: /home/mysql/.swt/lib/linux/x86_64/libswt-pi4-gtk.so

	at org.eclipse.swt.internal.Library.loadLibrary(Library.java:342)
	at org.eclipse.swt.internal.Library.loadLibrary(Library.java:256)
	at org.eclipse.swt.internal.gtk.OS.<clinit>(OS.java:90)
	at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:209)
	at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:155)
	at org.eclipse.swt.widgets.Display.<clinit>(Display.java:164)
	at org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.createProblemsViews(IDEWorkbenchPlugin.java:391)
	at org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.start(IDEWorkbenchPlugin.java:348)
	at org.eclipse.osgi.internal.framework.BundleContextImpl$3.run(BundleContextImpl.java:842)
	at org.eclipse.osgi.internal.framework.BundleContextImpl$3.run(BundleContextImpl.java:1)
	at java.security.AccessController.doPrivileged(Native Method)
	at org.eclipse.osgi.internal.framework.BundleContextImpl.startActivator(BundleContextImpl.java:834)
	at org.eclipse.osgi.internal.framework.BundleContextImpl.start(BundleContextImpl.java:791)
	at org.eclipse.osgi.internal.framework.EquinoxBundle.startWorker0(EquinoxBundle.java:1015)
	at org.eclipse.osgi.internal.framework.EquinoxBundle$EquinoxModule.startWorker(EquinoxBundle.java:365)
	at org.eclipse.osgi.container.Module.doStart(Module.java:603)
	at org.eclipse.osgi.container.Module.start(Module.java:467)
	at org.eclipse.osgi.framework.util.SecureAction.start(SecureAction.java:493)
	at org.eclipse.osgi.internal.hooks.EclipseLazyStarter.postFindLocalClass(EclipseLazyStarter.java:117)
	at org.eclipse.osgi.internal.loader.classpath.ClasspathManager.findLocalClass(ClasspathManager.java:571)
	at org.eclipse.osgi.internal.loader.ModuleClassLoader.findLocalClass(ModuleClassLoader.java:346)
	at org.eclipse.osgi.internal.loader.BundleLoader.findLocalClass(BundleLoader.java:398)
	at org.eclipse.osgi.internal.loader.sources.SingleSourcePackage.loadClass(SingleSourcePackage.java:41)
	at org.eclipse.osgi.internal.loader.BundleLoader.findClass(BundleLoader.java:473)
	at org.eclipse.osgi.internal.loader.ModuleClassLoader.loadClass(ModuleClassLoader.java:171)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
	at org.jkiss.dbeaver.ui.app.standalone.DBeaverApplication.setIDEWorkspace(DBeaverApplication.java:276)
	at org.jkiss.dbeaver.ui.app.standalone.DBeaverApplication.start(DBeaverApplication.java:161)
	at org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:203)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(EclipseAppLauncher.java:137)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAppLauncher.java:107)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:401)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:255)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:657)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:594)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1447)
	at org.eclipse.equinox.launcher.Main.main(Main.java:1420)

!ENTRY org.eclipse.osgi 4 0 2020-05-04 14:39:01.358
!MESSAGE アプリケーション・エラー
!STACK 1
java.lang.NoClassDefFoundError: org/eclipse/ui/internal/ide/ChooseWorkspaceData
	at org.jkiss.dbeaver.ui.app.standalone.DBeaverApplication.setIDEWorkspace(DBeaverApplication.java:276)
	at org.jkiss.dbeaver.ui.app.standalone.DBeaverApplication.start(DBeaverApplication.java:161)
	at org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:203)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(EclipseAppLauncher.java:137)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAppLauncher.java:107)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:401)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:255)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:657)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:594)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1447)
	at org.eclipse.equinox.launcher.Main.main(Main.java:1420)
Caused by: java.lang.ClassNotFoundException: バンドル org.eclipse.ui.ide (147) を自動的に有効化している間にエラーが発生しました。
	at org.eclipse.osgi.internal.hooks.EclipseLazyStarter.postFindLocalClass(EclipseLazyStarter.java:126)
	at org.eclipse.osgi.internal.loader.classpath.ClasspathManager.findLocalClass(ClasspathManager.java:571)
	at org.eclipse.osgi.internal.loader.ModuleClassLoader.findLocalClass(ModuleClassLoader.java:346)
	at org.eclipse.osgi.internal.loader.BundleLoader.findLocalClass(BundleLoader.java:398)
	at org.eclipse.osgi.internal.loader.sources.SingleSourcePackage.loadClass(SingleSourcePackage.java:41)
	at org.eclipse.osgi.internal.loader.BundleLoader.findClass(BundleLoader.java:473)
	at org.eclipse.osgi.internal.loader.ModuleClassLoader.loadClass(ModuleClassLoader.java:171)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
	... 15 more
Caused by: org.osgi.framework.BundleException: バンドル org.eclipse.ui.ide の org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.start() での例外。
	at org.eclipse.osgi.internal.framework.BundleContextImpl.startActivator(BundleContextImpl.java:863)
	at org.eclipse.osgi.internal.framework.BundleContextImpl.start(BundleContextImpl.java:791)
	at org.eclipse.osgi.internal.framework.EquinoxBundle.startWorker0(EquinoxBundle.java:1015)
	at org.eclipse.osgi.internal.framework.EquinoxBundle$EquinoxModule.startWorker(EquinoxBundle.java:365)
	at org.eclipse.osgi.container.Module.doStart(Module.java:603)
	at org.eclipse.osgi.container.Module.start(Module.java:467)
	at org.eclipse.osgi.framework.util.SecureAction.start(SecureAction.java:493)
	at org.eclipse.osgi.internal.hooks.EclipseLazyStarter.postFindLocalClass(EclipseLazyStarter.java:117)
	... 22 more
Caused by: java.lang.UnsatisfiedLinkError: Could not load SWT library. Reasons: 
	no swt-pi4-gtk-4932r18 in java.library.path
	no swt-pi4-gtk in java.library.path
	Can't load library: /home/mysql/.swt/lib/linux/x86_64/libswt-pi4-gtk-4932r18.so
	Can't load library: /home/mysql/.swt/lib/linux/x86_64/libswt-pi4-gtk.so

	at org.eclipse.swt.internal.Library.loadLibrary(Library.java:342)
	at org.eclipse.swt.internal.Library.loadLibrary(Library.java:256)
	at org.eclipse.swt.internal.gtk.OS.<clinit>(OS.java:90)
	at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:209)
	at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:155)
	at org.eclipse.swt.widgets.Display.<clinit>(Display.java:164)
	at org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.createProblemsViews(IDEWorkbenchPlugin.java:391)
	at org.eclipse.ui.internal.ide.IDEWorkbenchPlugin.start(IDEWorkbenchPlugin.java:348)
	at org.eclipse.osgi.internal.framework.BundleContextImpl$3.run(BundleContextImpl.java:842)
	at org.eclipse.osgi.internal.framework.BundleContextImpl$3.run(BundleContextImpl.java:1)
	at java.security.AccessController.doPrivileged(Native Method)
	at org.eclipse.osgi.internal.framework.BundleContextImpl.startActivator(BundleContextImpl.java:834)
	... 29 more
```

- 原因

  - 

- 対応

  - centosの方は安定していたので、そっちもありか

- 予防

  - 
