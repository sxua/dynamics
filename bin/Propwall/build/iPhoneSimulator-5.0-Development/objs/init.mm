#import <UIKit/UIKit.h>

extern "C" {
    void ruby_sysinit(int *, char ***);
    void ruby_init(void);
    void ruby_init_loadpath(void);
    void ruby_script(const char *);
    void ruby_set_argv(int, char **);
    void rb_vm_init_compiler(void);
    void rb_vm_init_jit(void);
    void rb_vm_aot_feature_provide(const char *, void *);
    void *rb_vm_top_self(void);
    void rb_rb2oc_exc_handler(void);
    void rb_exit(int);
void MREP_03153E4F31064F60A2AA2471DE78F19C(void *, void *);
void MREP_07DF5F06A6604AB2ACCA413CE32BFD66(void *, void *);
void MREP_6D0FF2CC2A78416FAFC97682A72CA7B2(void *, void *);
void MREP_74D5CDD0DC474313A194A9B32079D3C5(void *, void *);
void MREP_63E9604F95C347F4A68AD619ECF9801C(void *, void *);
void MREP_D016274F965D4D2099CF9E762F0D9331(void *, void *);
void MREP_31ED08949A9D4AF6A22797B61C0B37BE(void *, void *);
void MREP_12F2D60B1408476C885471073DCAB792(void *, void *);
void MREP_A023B07AC8CC4737927F995E27B89E2A(void *, void *);
void MREP_A69D0161D7D6459CB0E5C105A61DED13(void *, void *);
void MREP_0D9941C57F574EE4A8022444FD290F01(void *, void *);
void MREP_2ACEC8C44013416B93C32592B361A945(void *, void *);
void MREP_4842FCEFA6C0499DB0C798CB81BE865D(void *, void *);
void MREP_E04CCECD011F49BFAC90F60EA6B619B8(void *, void *);
void MREP_87727521BA96424AAD1511895D97C278(void *, void *);
void MREP_7814A6EDEEE44B02B40A91FFD9AB4BA5(void *, void *);
void MREP_13AC2AD01EEE47C88B39CEFED68083A1(void *, void *);
void MREP_05BA3A4591144F7EA11D5B0777E149CD(void *, void *);
void MREP_17DCBBDBC9DE406B8EB57572A0C2DB68(void *, void *);
void MREP_9684912604024F8B84542F2C77E8793F(void *, void *);
void MREP_038D9E2B95454C7F9E7D4FFB5DB08F3A(void *, void *);
void MREP_387AE7A646954E3CB4B8AF01235B89E4(void *, void *);
void MREP_460C89E5A89C497C9B9CACE384F3DA7B(void *, void *);
void MREP_38F28D2543664D50BD7025C575E6ECC8(void *, void *);
void MREP_598A1B8704DC4BB6A8E9BF77F84B87C7(void *, void *);
void MREP_50E44553F65D40EAA8DB0D5D8EB85CEF(void *, void *);
void MREP_7940DDE11A50487BA1E55DB838BE5817(void *, void *);
void MREP_42C6DB0079F849259EA1177B94DDA038(void *, void *);
void MREP_47E6B75F540645D7A23473D865D100F7(void *, void *);
void MREP_4EBFD37641104D04B9EB9C4388896B77(void *, void *);
}

extern "C"
void
RubyMotionInit(int argc, char **argv)
{
    static bool initialized = false;
    if (!initialized) {
	ruby_init();
	ruby_init_loadpath();
        if (argc > 0) {
	    const char *progname = argv[0];
	    ruby_script(progname);
	}
	try {
	    void *self = rb_vm_top_self();
MREP_03153E4F31064F60A2AA2471DE78F19C(self, 0);
MREP_07DF5F06A6604AB2ACCA413CE32BFD66(self, 0);
MREP_6D0FF2CC2A78416FAFC97682A72CA7B2(self, 0);
MREP_74D5CDD0DC474313A194A9B32079D3C5(self, 0);
MREP_63E9604F95C347F4A68AD619ECF9801C(self, 0);
MREP_D016274F965D4D2099CF9E762F0D9331(self, 0);
MREP_31ED08949A9D4AF6A22797B61C0B37BE(self, 0);
MREP_12F2D60B1408476C885471073DCAB792(self, 0);
MREP_A023B07AC8CC4737927F995E27B89E2A(self, 0);
MREP_A69D0161D7D6459CB0E5C105A61DED13(self, 0);
MREP_0D9941C57F574EE4A8022444FD290F01(self, 0);
MREP_2ACEC8C44013416B93C32592B361A945(self, 0);
MREP_4842FCEFA6C0499DB0C798CB81BE865D(self, 0);
MREP_E04CCECD011F49BFAC90F60EA6B619B8(self, 0);
MREP_87727521BA96424AAD1511895D97C278(self, 0);
MREP_7814A6EDEEE44B02B40A91FFD9AB4BA5(self, 0);
MREP_13AC2AD01EEE47C88B39CEFED68083A1(self, 0);
MREP_05BA3A4591144F7EA11D5B0777E149CD(self, 0);
MREP_17DCBBDBC9DE406B8EB57572A0C2DB68(self, 0);
MREP_9684912604024F8B84542F2C77E8793F(self, 0);
MREP_038D9E2B95454C7F9E7D4FFB5DB08F3A(self, 0);
MREP_387AE7A646954E3CB4B8AF01235B89E4(self, 0);
MREP_460C89E5A89C497C9B9CACE384F3DA7B(self, 0);
MREP_38F28D2543664D50BD7025C575E6ECC8(self, 0);
MREP_598A1B8704DC4BB6A8E9BF77F84B87C7(self, 0);
MREP_50E44553F65D40EAA8DB0D5D8EB85CEF(self, 0);
MREP_7940DDE11A50487BA1E55DB838BE5817(self, 0);
MREP_42C6DB0079F849259EA1177B94DDA038(self, 0);
MREP_47E6B75F540645D7A23473D865D100F7(self, 0);
MREP_4EBFD37641104D04B9EB9C4388896B77(self, 0);
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
	initialized = true;
    }
}
