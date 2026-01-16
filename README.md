# IKE Parent POM

Parent POM for IKE Community projects providing standardized build configuration.

## Features

- **Java 25** with preview features enabled by default
- **Maven 4** (model version 4.1.0)
- **JPMS-compatible testing** (classpath mode for test execution)
- **GitFlow** branch versioning via gitflow-maven-plugin
- **Release profile** for source and javadoc JAR generation
- **Standard plugins** pre-configured (compiler, surefire, failsafe, javadoc, source)

## Usage

Add as parent in your project's `pom.xml`:

```xml
<parent>
    <groupId>dev.ikm</groupId>
    <artifactId>ike-parent</artifactId>
    <version>1.0.0-SNAPSHOT</version>
</parent>
```

## Configuration

### Java Version

Override the Java version if needed:

```xml
<properties>
    <maven.compiler.release>21</maven.compiler.release>
</properties>
```

### Distribution URLs

Set deployment repository URLs via command line or `settings.xml`:

```bash
mvn deploy -Ddeploy.release.url=https://your-repo/releases \
           -Ddeploy.snapshot.url=https://your-repo/snapshots
```

Or in `~/.m2/settings.xml`:

```xml
<profiles>
    <profile>
        <id>ike</id>
        <properties>
            <deploy.release.url>https://your-repo/releases</deploy.release.url>
            <deploy.snapshot.url>https://your-repo/snapshots</deploy.snapshot.url>
        </properties>
    </profile>
</profiles>
<activeProfiles>
    <activeProfile>ike</activeProfile>
</activeProfiles>
```

## Plugins

### Active by Default

| Plugin | Purpose |
|--------|---------|
| `maven-compiler-plugin` | Java compilation with preview features |
| `maven-surefire-plugin` | Unit tests (classpath mode, add-opens for reflection) |
| `gitflow-maven-plugin` | GitFlow branch operations |

### Release Profile

The following plugins are activated during releases (when `-DperformRelease=true`):

| Plugin | Purpose |
|--------|---------|
| `maven-source-plugin` | Source JAR attachment |
| `maven-javadoc-plugin` | Javadoc generation with preview support |

The GitFlow plugin automatically activates this profile during `release-finish` and `hotfix-finish`.

### Available in Plugin Management

These plugins are pre-configured but not active by default. Add to your project's `<build><plugins>` section to activate:

| Plugin | Purpose |
|--------|---------|
| `maven-failsafe-plugin` | Integration tests |
| `maven-jar-plugin` | JAR packaging |
| `maven-assembly-plugin` | Custom assemblies |
| `maven-resources-plugin` | Resource processing |
| `maven-deploy-plugin` | Artifact deployment |
| `maven-install-plugin` | Local installation |
| `maven-clean-plugin` | Build cleanup |

## GitFlow Commands

```bash
# Start a feature branch
./mvnw gitflow:feature-start -DfeatureName=my-feature

# Finish a feature branch
./mvnw gitflow:feature-finish

# Start a release
./mvnw gitflow:release-start

# Finish a release (activates release profile for source/javadoc JARs)
./mvnw gitflow:release-finish

# Start a hotfix
./mvnw gitflow:hotfix-start -DhotfixVersion=1.0.1

# Finish a hotfix (activates release profile for source/javadoc JARs)
./mvnw gitflow:hotfix-finish
```

## Integration Tests

To enable integration tests in a child project, add the failsafe plugin to your build:

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-failsafe-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

Then run with `mvn verify`.

## License

Apache License, Version 2.0
