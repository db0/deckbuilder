extends Memory

func execute_memory_effect():
	globals.player.pathos.repress_pathos(
			Terms.RUN_ACCUMULATION_NAMES.boss, MemoryDefinitions.BossFaster.amounts.pathos_amount)
	_send_trigger_signal()
