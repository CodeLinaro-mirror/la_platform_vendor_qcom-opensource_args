pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = ar_osal.pc
EXTRA_DIST = $(pkgconfig_DATA)

AM_CFLAGS = -Wall -Wno-pointer-to-int-cast -Wno-error=unused-function \
            -Wno-error=unused-label
AM_CFLAGS += @QMIF_CFLAGS@
AM_CFLAGS += @PDMAPPER_CFLAGS@
AM_CFLAGS += @PDNOTIFIER_CFLAGS@
AM_CFLAGS += -D__unused=__attribute__\(\(__unused__\)\) -DLINUX_ENABLED \
             -DAR_OSAL_USE_PD_NOTIFIER

if WITHOUT_SPF_RESTART
AM_CFLAGS += -DAR_OSAL_SPF_RESTART_DISABLED
endif

AM_CFLAGS += -I$(srcdir)/api
AM_CFLAGS += -I ${WORKSPACE}/ss-services/pd-mapper/libpdmapper
AM_CFLAGS += -I ${WORKSPACE}/ss-services/pd-notifier/libpdnotifier
AM_CFLAGS += -I ${WORKSPACE}/ss-services/pd-notifier/pd-notifier-idl
AM_CFLAGS += -I ${WORKSPACE}/ss-services/pd-mapper/pd-mapper-idl

AM_CFLAGS += -I$(srcdir)/api

osal_sources = ./api/ar_osal_error.h \
               ./api/ar_osal_dyn_pd.h \
               ./api/ar_osal_file_io.h \
               ./api/ar_osal_heap.h \
               ./api/ar_osal_log.h \
               ./api/ar_osal_mem_op.h \
               ./api/ar_osal_mutex.h \
               ./api/ar_osal_servreg.h \
               ./api/ar_osal_shmem.h \
               ./api/ar_osal_signal.h \
               ./api/ar_osal_sleep.h \
               ./api/ar_osal_string.h \
               ./api/ar_osal_sys_id.h \
               ./api/ar_osal_thread.h \
               ./api/ar_osal_timer.h \
               ./api/ar_osal_types.h

osal_c_sources = ./src/linux/ar_osal_file_io.c \
                 ./src/linux/ar_osal_heap.c \
                 ./src/linux/ar_osal_log.c \
                 ./src/linux/ar_osal_mem_op.c \
                 ./src/linux/ar_osal_mutex.c \
                 ./src/linux/ar_osal_signal.c \
                 ./src/linux/ar_osal_sleep.c \
                 ./src/linux/ar_osal_string.c \
                 ./src/linux/ar_osal_thread.c \
                 ./src/linux/ar_osal_timer.c \
                 ./src/linux/qcom/dyn_pd/ar_osal_dyn_pd.c \
                 ./src/linux/qcom/ar_osal_servreg.c


if AUDIO_DMA_SUPPORT
osal_c_sources += ./src/linux/qcom/ar_osal_shmem_db.c
else
osal_c_sources += ./src/linux/qcom/ar_osal_shmem.c
endif


if USE_DUMMY_DIAG
osal_c_sources += ./src/linux/ar_osal_stub_log_pkt_op.c
else
osal_c_sources += ./src/linux/qcom/ar_osal_log_pkt_op.c
endif


if ARGS_USE_SYSLOG
AM_CFLAGS += -DAR_OSAL_USE_SYSLOG
endif

libar_osal_la_LIBADD = -lrt -lpthread @QMIF_LIBS@ @PDMAPPER_LIBS@ @PDNOTIFIER_LIBS@

if TARGET_AUDIO_DYNAMIC_PD_ENABLED
osal_c_sources += ./src/linux/qcom/dyn_pd/cdsp_dyn_pd_stub.c
AM_CFLAGS += -DAR_OSAL_USE_DYNAMIC_PD
libar_osal_la_LIBADD += -ladsprpc
endif

if CUTILS_SUPPORTED
libar_osal_la_LIBADD += -lcutils
AM_CFLAGS += -DAR_OSAL_USE_CUTILS
endif

if USE_GLIB
libar_osal_la_LIBADD += -lglib-2.0
AM_CFLAGS += $(GLIB_CFLAGS) -D_GNU_SOURCE -include glib.h
endif

if NO_STRLCPY_STRLCAT
AM_CFLAGS += -Dstrlcpy=g_strlcpy -Dstrlcat=g_strlcat
endif

if ION_DRIVER_NOT_SUPPORTED
AM_CFLAGS += -DION_DRIVER_UNSUPPORTED
endif

lib_includedir = $(includedir)
lib_include_HEADERS = $(osal_sources)
lib_LTLIBRARIES = libar-osal.la
libar_osal_la_CC = @CC@
libar_osal_la_SOURCES = $(osal_c_sources)
libar_osal_la_CFLAGS = $(AM_CFLAGS) @DIAG_CFLAGS@

if LIBION_SUPPORTED
libar_osal_la_LIBADD += -lion
libar_osal_la_CFLAGS += @LIBION_CFLAGS@
endif

libar_osal_la_LDFLAGS = -shared -avoid-version

if !USE_DUMMY_DIAG
AM_CFLAGS += @DIAG_CFLAGS@
libar_osal_la_LDFLAGS += @DIAG_LIBS@
else
AM_CFLAGS += -I$(top_srcdir)/acdb/ats/transports/diag/linux/inc/
endif
