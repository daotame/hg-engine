.include "asm/include/battle_commands.inc"

.data

_000:
    CompareVarToValue OPCODE_FLAG_SET, BSCRIPT_VAR_MOVE_STATUS_FLAGS, MOVE_STATUS_SEMI_INVULNERABLE, _097
    CheckIgnorableAbility CHECK_OPCODE_HAVE, BATTLER_CATEGORY_DEFENDER, ABILITY_SUCTION_CUPS, _102
    CompareMonDataToValue OPCODE_EQU, BATTLER_CATEGORY_DEFENDER, BMON_DATA_MOVE_EFFECT, MOVE_EFFECT_FLAG_INGRAIN, _109
    CompareVarToValue OPCODE_EQU, BSCRIPT_VAR_BATTLE_TYPE, BATTLE_TYPE_AI|BATTLE_TYPE_MULTI|BATTLE_TYPE_DOUBLES, _097
    CompareVarToValue OPCODE_LTE, BSCRIPT_VAR_BATTLER_FAINTED, BATTLER_FORCED_OUT, _097
    CompareVarToValue OPCODE_EQU, BSCRIPT_VAR_BATTLE_TYPE, BATTLE_TYPE_WILD_MON, _038

_030:
    TryReplaceFaintedMon BATTLER_CATEGORY_DEFENDER, TRUE, _097
    TryWhirlwind _030
    GoTo _040

_038:
    GoTo _126

_040:
    CompareVarToValue OPCODE_EQU, BSCRIPT_VAR_BATTLE_TYPE, BATTLE_TYPE_WILD_MON, _126
    Call BATTLE_SUBSCRIPT_ATTACK_MESSAGE_AND_ANIMATION
    TryRestoreStatusOnSwitch BATTLER_CATEGORY_DEFENDER, _055
    UpdateMonData OPCODE_SET, BATTLER_CATEGORY_DEFENDER, BMON_DATA_STATUS, STATUS_NONE

_055:
    DeletePokemon BATTLER_CATEGORY_DEFENDER
    Wait 
    CompareVarToValue OPCODE_FLAG_NOT, BSCRIPT_VAR_BATTLE_TYPE, BATTLE_TYPE_TRAINER, _090
    HealthbarSlideOut BATTLER_CATEGORY_DEFENDER
    Wait 
    SwitchAndUpdateMon BATTLER_CATEGORY_FORCED_OUT
    Wait 
    PokemonSendOut BATTLER_CATEGORY_DEFENDER
    WaitTime 72
    HealthbarSlideIn BATTLER_CATEGORY_DEFENDER
    Wait 
    // {0} was dragged out!
    PrintMessage 603, TAG_NICKNAME, BATTLER_CATEGORY_DEFENDER
    Wait 
    WaitButtonABTime 30
    UpdateVarFromVar OPCODE_SET, BSCRIPT_VAR_BATTLER_SWITCH, BSCRIPT_VAR_BATTLER_TARGET
    Call BATTLE_SUBSCRIPT_HAZARDS_CHECK
    End 

_090:
    FadeOutBattle 
    Wait 
    UpdateVar OPCODE_FLAG_ON, BSCRIPT_VAR_BATTLE_OUTCOME, BATTLE_RESULT_PLAYER_FLED
    End 

_097:
    UpdateVar OPCODE_FLAG_ON, BSCRIPT_VAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    End 

_102:
    // {0} anchors itself with {1}!
    BufferMessage 659, TAG_NICKNAME_ABILITY, BATTLER_CATEGORY_DEFENDER, BATTLER_CATEGORY_DEFENDER
    GoTo _113

_109:
    // {0} anchored itself with its roots!
    BufferMessage 542, TAG_NICKNAME, BATTLER_CATEGORY_DEFENDER

_113:
    PrintAttackMessage 
    Wait 
    WaitButtonABTime 30
    PrintBufferedMessage 
    Wait 
    WaitButtonABTime 30
    UpdateVar OPCODE_FLAG_ON, BSCRIPT_VAR_MOVE_STATUS_FLAGS, MOVE_STATUS_NO_MORE_WORK
    End 

_126:
    IsAttackerLevelLowerThanDefender _097
    Call BATTLE_SUBSCRIPT_ATTACK_MESSAGE_AND_ANIMATION
    TryRestoreStatusOnSwitch BATTLER_CATEGORY_DEFENDER, _055
    UpdateMonData OPCODE_SET, BATTLER_CATEGORY_DEFENDER, BMON_DATA_STATUS, STATUS_NONE
    GoTo _055
