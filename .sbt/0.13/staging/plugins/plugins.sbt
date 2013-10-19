
// The ENSIME plugin
addSbtPlugin("org.ensime" % "ensime-sbt-cmd" % "0.1.1")

addSbtPlugin("com.typesafe.sbt" % "sbt-git" % "0.5.0")

addSbtPlugin("me.lessis" % "ls-sbt" % "0.1.2")

//addSbtPlugin("com.github.gseitz" % "sbt-release" % "0.6")

resolvers ++= Seq(
  "jgit-repo" at "http://download.eclipse.org/jgit/maven",
  "less is" at "http://repo.lessis.me",
  "coda" at "http://repo.codahale.com",
  Classpaths.sbtPluginReleases,
  Opts.resolver.sonatypeReleases
)
