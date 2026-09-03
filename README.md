This project focuses on the micro architecture to GDS skipping the verification of a **32-bit RISC-V Single-Cycle Processor** using Verilog HDL.

The processor is based on the fundamental principles of a single-cycle CPU architecture, 
where each instruction is fetched, decoded, executed, and completed within a single clock cycle.

<img width="535" height="313" alt="image" src="https://github.com/user-attachments/assets/75d72800-7668-47d3-899a-d400895e0f24" />


source:http://www.r-5.org/files/books/computers/hw-layers/hardware/digital-desigh/David_Harris_Sarah_Harris-Digital_Design_and_Computer_Architecture-EN.pdf
page Number: 375


| Feature                 | MIPS                                               | RISC-V                                      |
| ----------------------- | -------------------------------------------------- | ------------------------------------------- |
| Full name               | Microprocessor without Interlocked Pipeline Stages | RISC-V                                      |
| ISA type                | RISC                                               | RISC                                        |
| Registers               | 32 general-purpose registers                       | 32 general-purpose registers                |
| Register size           | MIPS32 → 32-bit                                    | RV32 → 32-bit                               |
| Register naming         | `$t0`, `$t1`, `$s0`, etc.                          | `x5`, `x6`, etc. (`t0`, `t1` are ABI names) |
| Instruction length      | 32 bits for MIPS32 basic instructions              | 32 bits for base RV32I                      |
| Immediate               | Commonly 16-bit in I-type MIPS instructions        | 12-bit in I-type RV32I                      |
| R-type                  | ✅                                                  | ✅                                           |
| I-type                  | ✅                                                  | ✅                                           |
| S-type                  | ❌                                                  | ✅                                           |
| B-type                  | ❌ as a separate format                             | ✅                                           |
| U-type                  | ❌                                                  | ✅                                           |
| J-type                  | ✅                                                  | ❌ as a separate format; RISC-V has J-type   |
| Zero register           | `$zero` = register 0                               | `x0` = always 0                             |
| ISA philosophy          | Older, relatively fixed ISA                        | Modern, modular ISA                         |
| Extensions              | Various MIPS versions                              | `I`, `M`, `A`, `F`, `D`, `C`, `V`, etc.     |
| Open ISA                | ❌                                                  | ✅                                           |
| Your shown architecture | **MIPS**                                           | ❌                                           |
