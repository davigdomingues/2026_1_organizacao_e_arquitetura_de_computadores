# tipos das instruções (6 tipos -> sumário):
# Register (R): add <rd>, <rs1>, <rs2>
# Immediate (I): lw <rd>, imm(<rs1>)
# Store (S): sw <rs2>, imm(<rs1>)
# Branch(B): beq <rs1>, <rs2>, imm
# Upper (U): lui <rs1>, imm
# Jump (J): jal <rd>, imm

# Esquema de exemplo:

# ====================================================================================
# FORMATO TIPO-R (Register-Register)
# Usado para operações aritméticas e lógicas entre registradores.
# Estrutura: [funct7 (7b)] [rs2 (5b)] [rs1 (5b)] [funct3 (3b)] [rd (5b)] [opcode (7b)]
# ====================================================================================
add  rd, rs1, rs2    # rd = rs1 + rs2 (Soma valores de dois registradores)
sub  rd, rs1, rs2    # rd = rs1 - rs2 (Subtração)
and  rd, rs1, rs2    # rd = rs1 & rs2 (E lógico bit a bit)
or   rd, rs1, rs2    # rd = rs1 | rs2 (OU lógico bit a bit)
sll  rd, rs1, rs2    # rd = rs1 << rs2 (Shift Left Logical)

# ====================================================================================
# FORMATO TIPO-I (Immediate & Load)
# Operações com constantes de 12 bits ou leitura da memória (Load).
# Estrutura: [imm[11:0] (12b)] [rs1 (5b)] [funct3 (3b)] [rd (5b)] [opcode (7b)]
# ====================================================================================
addi rd, rs1, imm    # rd = rs1 + imm (Soma registrador com constante)
lw   rd, imm(rs1)    # rd = M[rs1 + imm] (Carrega palavra da memória para o reg)
lb   rd, imm(rs1)    # rd = M[rs1 + imm] (Carrega apenas 1 byte com sinal)
jalr rd, imm(rs1)    # rd = PC+4; PC = rs1 + imm (Salto indireto para função)

# ====================================================================================
# FORMATO TIPO-S (Store)
# Escrita de dados em endereços de memória. O imediato é partido em dois campos.
# Estrutura: [imm[11:5]] [rs2 (5b)] [rs1 (5b)] [funct3 (3b)] [imm[4:0]] [opcode (7b)]
# ====================================================================================
sw   rs2, imm(rs1)   # M[rs1 + imm] = rs2 (Salva palavra do reg na memória)
sb   rs2, imm(rs1)   # M[rs1 + imm] = rs2[7:0] (Salva apenas o byte menos signif.)
sh   rs2, imm(rs1)   # M[rs1 + imm] = rs2[15:0] (Salva meia palavra/halfword)

# ====================================================================================
# FORMATO TIPO-B (Branch/Desvio)
# Desvios condicionais. O imediato de 13 bits é codificado de forma embaralhada.
# Estrutura: [imm[12|10:5]] [rs2] [rs1] [funct3] [imm[4:1|11]] [opcode]
# ====================================================================================
beq  rs1, rs2, label # if (rs1 == rs2) PC += imm (Pula se igual)
bne  rs1, rs2, label # if (rs1 != rs2) PC += imm (Pula se diferente)
blt  rs1, rs2, label # if (rs1 < rs2)  PC += imm (Pula se menor - com sinal)
bge  rs1, rs2, label # if (rs1 >= rs2) PC += imm (Pula se maior ou igual)

# ====================================================================================
# FORMATO TIPO-U (Upper Immediate)
# Carrega constantes grandes (20 bits) nos bits superiores (MSB).
# Estrutura: [imm[31:12] (20b)] [rd (5b)] [opcode (7b)]
# ====================================================================================
lui   rd, imm        # rd = imm << 12 (Carrega constante alta no registrador)
auipc rd, imm        # rd = PC + (imm << 12) (Adiciona constante alta ao PC atual)

# ====================================================================================
# FORMATO TIPO-J (Jump)
# Saltos incondicionais de longo alcance (21 bits de endereço).
# Estrutura: [imm[20|10:1|11|19:12]] [rd (5b)] [opcode (7b)]
# ====================================================================================
jal  rd, label       # rd = PC+4; PC += imm (Salto para função e salva retorno)