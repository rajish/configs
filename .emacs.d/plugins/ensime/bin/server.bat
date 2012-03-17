set PORT_FILE=%1
set CLASSPATH="%~dp0\..\lib\ant-1.8.1.jar;%~dp0\..\lib\ant-1.6.5.jar;%~dp0\..\lib\maven-model-2.2.1.jar;%~dp0\..\lib\maven-project-2.2.1.jar;%~dp0\..\lib\maven-repository-metadata-2.2.1.jar;%~dp0\..\lib\org.scala-refactoring_2.9.2-SNAPSHOT-0.5.0-SNAPSHOT.jar;%~dp0\..\lib\classworlds-1.1-alpha-2.jar;%~dp0\..\lib\wagon-file-1.0-beta-6.jar;%~dp0\..\lib\wagon-http-lightweight-1.0-beta-6.jar;%~dp0\..\lib\backport-util-concurrent-3.1.jar;%~dp0\..\lib\wagon-http-shared-1.0-beta-6.jar;%~dp0\..\lib\maven-plugin-registry-2.2.1.jar;%~dp0\..\lib\ensime_2.9.2-SNAPSHOT-0.9.3.RC3.jar;%~dp0\..\lib\ivy-2.1.0.jar;%~dp0\..\lib\ant-launcher-1.8.1.jar;%~dp0\..\lib\plexus-interpolation-1.11.jar;%~dp0\..\lib\asm-commons-3.2.jar;%~dp0\..\lib\critbit-0.0.4.jar;%~dp0\..\lib\scalariform_2.9.1-0.1.1.jar;%~dp0\..\lib\maven-error-diagnostics-2.2.1.jar;%~dp0\..\lib\plexus-utils-1.5.15.jar;%~dp0\..\lib\scala-library.jar;%~dp0\..\lib\plexus-container-default-1.0-alpha-9-stable-1.jar;%~dp0\..\lib\asm-tree-3.2.jar;%~dp0\..\lib\xercesMinimal-1.9.6.2.jar;%~dp0\..\lib\maven-profile-2.2.1.jar;%~dp0\..\lib\asm-3.2.jar;%~dp0\..\lib\wagon-provider-api-1.0-beta-6.jar;%~dp0\..\lib\nekohtml-1.9.6.2.jar;%~dp0\..\lib\maven-ant-tasks-2.1.0.jar;%~dp0\..\lib\maven-artifact-manager-2.2.1.jar;%~dp0\..\lib\maven-artifact-2.2.1.jar;%~dp0\..\lib\scala-compiler.jar;%~dp0\..\lib\org.eclipse.jdt.core-3.6.0.v_A58.jar;%~dp0\..\lib\maven-settings-2.2.1.jar"
if "%ENSIME_JVM_ARGS%"=="" (set ENSIME_JVM_ARGS=-XX:+DoEscapeAnalysis -Xms256M -Xmx1512M -XX:PermSize=128m -Xss1M -Dfile.encoding=UTF-8)
java -classpath %CLASSPATH% %ENSIME_JVM_ARGS% org.ensime.server.Server %PORT_FILE%
