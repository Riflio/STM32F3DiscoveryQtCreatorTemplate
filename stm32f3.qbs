import qbs
import qbs.FileInfo
import qbs.ModUtils

Product {    
    name: "STM32F3Discovery"
    type: ["application"]

    Depends { name:"cpp" }
        
    property string libPath: path+"/stm32f3/"

    consoleApplication: true

    cpp.positionIndependentCode: false
    cpp.executableSuffix: ".elf"

    cpp.includePaths: [        
        libPath,
        libPath + "StdPeriph_Driver/inc/",
        libPath + "CMSIS/Include/",
        libPath + "CMSIS/Device/ST/STM32F30x/Include/"
    ]

    files: [        
    ]

    cpp.defines: [
        "STM32F30X",
        "USE_STDPERIPH_DRIVER"
    ]

    Properties {
        condition: cpp.debugInformation
        cpp.defines: outer.concat("DEBUG")
    }

    cpp.commonCompilerFlags: [
        "-mthumb",
        "-mcpu=cortex-m4",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
    ]

    cpp.linkerFlags: [
        "-T"+libPath+"ldscripts/stm32f3discovery_def.ld",
        "-T"+libPath+"ldscripts/sections_flash.ld",
        "-mthumb",
        "-mcpu=cortex-m4",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "--specs=nosys.specs",
        "-ffunction-sections",
        "-fdata-sections",
        "-Wl,--gc-sections",
        libPath+"CMSIS/Device/ST/STM32F30x/Source/Templates/gcc_ride7/startup_stm32f30x.s",
    ]


    cpp.cxxFlags: ["-std=c++11"]
    cpp.cFlags: ["-std=gnu99"]
    cpp.warningLevel: "all"


    Group {
        name: "Sources"
        files: [
            "*.c"
        ]
    }

    Group {
        name: "StdPeriph_Driver"
        prefix: libPath+"StdPeriph_Driver/**/"
        files: [
            "*.h",
            "*.c",
        ]
    }

    Group {
        name: "System"
        files: [
            libPath + "CMSIS/Device/ST/STM32F30x/Source/Templates/system_stm32f30x.c",
        ]
    }

}


