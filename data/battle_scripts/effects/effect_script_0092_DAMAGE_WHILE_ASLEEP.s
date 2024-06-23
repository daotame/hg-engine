.include "asm/include/battle_commands.inc"

.data

_000:
    CompareMonDataToValue OPCODE_FLAG_NOT, BATTLER_CATEGORY_ATTACKER, BMON_DATA_STATUS, STATUS_SLEEP, _019
    CompareVarToValue OPCODE_EQU, BSCRIPT_VAR_MOVE_NO_TEMP, MOVE_SLEEP_TALK, _012
    Call BATTLE_SUBSCRIPT_SLEEPING

_012:
    UpdateVar OPCODE_FLAG_ON, BSCRIPT_VAR_SIDE_EFFECT_FLAGS_INDIRECT, MOVE_SIDE_EFFECT_TO_DEFENDER|MOVE_SUBSCRIPT_PTR_FLINCH
    CalcCrit 
    CalcDamage 
    End 

_019:
    UpdateVar OPCODE_FLAG_ON, BSCRIPT_VAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    End 
