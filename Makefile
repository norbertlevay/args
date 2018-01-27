
builddate=$(shell date)


all: main


build_date.ads :
	@echo "package Build_Date is" > build_date.ads
	@echo "BuildDate : constant String := \"${builddate}\";" >> build_date.ads
	@echo "end Build_Date;" >> build_date.ads

main : main.adb build_date.ads options.ads options.adb
	gnatmake -g -gnat05 -we main.adb -o main -bargs -E
# -bargs -E ?? -> for addr2line ?? at excpetion
# -we turns warnings into errors
# -gnaty <-- prints warnings on identation style

.PHONY: clean distclean


clean:
	rm -f main *.o *.ali build_date.* b~*.ad? b~*.ad?

distclean: clean
	make distclean -C doc
	rm -f *~ test-modifyheader.hdr
