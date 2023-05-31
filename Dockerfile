FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y clang-format clang-tidy \
    cmake git

RUN mkdir codeToTest

#ADD ./src /codeToTest

RUN git clone https://github.com/WorHyako/DockerStyleCheckerTest

# Load code style file 
RUN git clone https://github.com/WorHyako/WorCodeStyle.git

WORKDIR /codeToTest/DockerStyleCheckerTest\src

# Copy code style file to cpp project root directory
RUN cp ../../WorCodeStyle/.clang-format .clang-format

# Generate CMake cache and compile commands 
RUN mkdir build && cmake ../ -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Build code to help clang-tidy
RUN /opt/homebrew/Cellar/llvm/16.0.4/bin/run-clang-tidy . -p cmake-build-debug

# Run clang-format and apply fixes
RUN find . -name "*.*pp" -type f -exec clang-format -i -style=file {} \;

# Run git to check all difference and write to clang-format-log file
RUN git diff > clang-format-log && \
    git reset --hard

# Run clang-tidy
# I use `clang-tidy` insteed `run-clang-tidy` cause the second one write to output too much checkers info
RUN find . -name "*.*pp" -type f -exec clang-tidy -p build {} \; > clang-tidy-log
