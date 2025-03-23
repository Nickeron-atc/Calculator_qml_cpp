cmake_minimum_required(VERSION 3.14)

project(QmlApp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

# Добавляем пакет Quick
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

add_custom_target(clean-build
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}
    COMMENT "Удаление директории build"
)

# Копирование QML файлов и шрифтов в build directory
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/main.qml DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

# Копирование всей папки Fonts с сохранением структуры
file(COPY
    ${CMAKE_CURRENT_SOURCE_DIR}/Fonts
    DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
    PATTERN "*.qml"
    PATTERN "*.ttf"
    PATTERN "qmldir"
)

# Копирование всей папки Components с сохранением структуры
file(COPY
    ${CMAKE_CURRENT_SOURCE_DIR}/Components
    DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
    PATTERN "*.qml"
    PATTERN "qmldir"
)


qt_standard_project_setup()

# Определяем компилируемые файлы
qt_add_executable(QmlApp
    main.cpp
    backend.cpp
    calculator.cpp
)


# Добавляем файлы qml
qt_add_qml_module(QmlApp
    URI path
    VERSION 1.0
    QML_FILES main.qml Fonts/BaseFont.qml Fonts/OpenSans_01.qml
    QML_FILES Components/CustomButton_01.qml
    SOURCES main.cpp
    SOURCES backend.h backend.cpp
    SOURCES calculator.h calculator.cpp
)


target_link_libraries(QmlApp
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS QmlApp
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
