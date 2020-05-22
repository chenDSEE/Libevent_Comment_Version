#cds

#LINK.o := $(LINK.cc)
CC := $(CXX) #enable this if you are handling CPP
make_flag := -g -O0
target := test
dep := $(patsubst %.cpp, %.d, $(wildcard *.cpp))
obj := $(patsubst %.cpp, %.o, $(wildcard *.cpp))
inc_path := -I./event_lib/include/
#inc_path += ./event_lib/include/
lib_path := -L./event_lib/lib/
#lib_path += ./event_lib/lib/
link_lib := -levent
#link_lib += 

.PHONY : all clean

all : $(target)


# 1.if .c has include new .h, this will make .d to be updated,
# otherwise, .d had no need to update
# 
# 2. .d file can only to create .h denpendce !!! .o : .c you have handle by you salf
# 3. only create dependce, the command will be created by Makefile !!(but not gcc -MM !!)
%.d : %.cpp
	$(CC) -MM $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

include $(dep)

# if this is enable, this can override default rule !!!
%.o : %.cpp
	echo aimer
	$(CC) $(inc_path) $(make_flag) -c $< -o $@

$(target) : $(obj)
	$(CC)  $(make_flag) $^ -o $@ $(lib_path) $(link_lib) -Wl,-rpath=/root/dm_event/event_lib/lib

# the reason why you have to special this "a : 1.o" is:
# "a" is an ELF programe, but not "a.c", programe "a" have to link which *.o file
# have no idea to create by Makefile System


clean : 
	-rm $(target) $(dep) $(obj)









#target := a
#tar_dir := ../tar/
#dir := ../obj/a_obj/
#src := $(wildcard *.c)
#obj_d := $(src:.c=.o)
#obj := $(addprefix $(dir), $(obj_d))
#
#
#.PHONY : all clean
#
#all : $(target)
#
#vpath %.o $(dir)
#
#%.o : %.c
#       cc -c $< -o $(dir)$@
#
#$(target) : $(obj_d)
#       gcc $^ -o $(tar_dir)$@ -I$(dir)
#
#
#clean : 
#       -rm $(tar_dir)$(target) $(obj)






