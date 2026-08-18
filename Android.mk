ifeq ($(filter true,$(AUDIO_USE_STUB_HAL) $(TARGET_SDV_ENABLED)),)
    include $(call all-subdir-makefiles)
endif