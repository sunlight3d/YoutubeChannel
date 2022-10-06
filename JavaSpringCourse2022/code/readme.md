Install Spring Boot CLI
-download zip file, unzip
-add path to .zshrc
export PATH="/Users/hoangnd/Documents/spring-2.7.2/bin:$PATH"
Make path available:
source ~/.zshrc
spring --version

Create new project:
spring init --list
spring init --build=gradle \
--java-version=18 \
--dependencies=web,lombok \
--packaging=war \
--language=kotlin \
--package-name=com.training \
--name=training-app \
training-app

./gradlew bootRun
OR:
./gradlew build
java -jar ./build/libs/training-app-0.0.1-SNAPSHOT.war


