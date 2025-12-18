; ModuleID = 'sailfin'
source_filename = "sailfin"

; -- Trait Metadata --------------------------------
; interface Meter
;   fn total(self -> Meter) -> number
;
; struct Person implements Meter
; -----------------------------------------------

%Person = type { double }

%trait.Meter = type { i8*, i8* }

%vtable.Person.Meter = type { double (i8*)* }

@vtable.Person.Meter.const = global %vtable.Person.Meter { double (i8*)* bitcast (double (i8*)* @Persontotal to double (i8*)*) }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

define { %Person*, i64 }* @make_people() {
block.entry:
  %t0 = sitofp i64 36 to double
  %t1 = insertvalue %Person undef, double %t0, 0
  %t2 = sitofp i64 42 to double
  %t3 = insertvalue %Person undef, double %t2, 0
  %t4 = getelementptr [2 x %Person], [2 x %Person]* null, i32 1
  %t5 = ptrtoint [2 x %Person]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to %Person*
  %t10 = getelementptr %Person, %Person* %t9, i64 0
  store %Person %t1, %Person* %t10
  %t11 = getelementptr %Person, %Person* %t9, i64 1
  store %Person %t3, %Person* %t11
  %t12 = getelementptr { %Person*, i64 }, { %Person*, i64 }* null, i32 1
  %t13 = ptrtoint { %Person*, i64 }* %t12 to i64
  %t14 = call i8* @malloc(i64 %t13)
  %t15 = bitcast i8* %t14 to { %Person*, i64 }*
  %t16 = getelementptr { %Person*, i64 }, { %Person*, i64 }* %t15, i32 0, i32 0
  store %Person* %t9, %Person** %t16
  %t17 = getelementptr { %Person*, i64 }, { %Person*, i64 }* %t15, i32 0, i32 1
  store i64 2, i64* %t17
  ret { %Person*, i64 }* %t15
}

define double @total_years({ %Person*, i64 }* %values) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i64
  %l2 = alloca %Person
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = getelementptr { %Person*, i64 }, { %Person*, i64 }* %values, i32 0, i32 1
  %t2 = load i64, i64* %t1
  %t3 = getelementptr { %Person*, i64 }, { %Person*, i64 }* %values, i32 0, i32 0
  %t4 = load %Person*, %Person** %t3
  store i64 0, i64* %l1
  store %Person zeroinitializer, %Person* %l2
  br label %for0
for0:
  %t5 = load i64, i64* %l1
  %t6 = icmp slt i64 %t5, %t2
  br i1 %t6, label %forbody1, label %afterfor3
forbody1:
  %t7 = load i64, i64* %l1
  %t8 = getelementptr %Person, %Person* %t4, i64 %t7
  %t9 = load %Person, %Person* %t8
  store %Person %t9, %Person* %l2
  %t10 = load double, double* %l0
  %t11 = load %Person, %Person* %l2
  %t12 = extractvalue %Person %t11, 0
  %t13 = fadd double %t10, %t12
  store double %t13, double* %l0
  br label %forinc2
forinc2:
  %t14 = load i64, i64* %l1
  %t15 = add i64 %t14, 1
  store i64 %t15, i64* %l1
  br label %for0
afterfor3:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l0
  ret double %t17
}

define double @main() {
block.entry:
  %l0 = alloca { %Person*, i64 }*
  %t0 = call { %Person*, i64 }* @make_people()
  store { %Person*, i64 }* %t0, { %Person*, i64 }** %l0
  %t1 = load { %Person*, i64 }*, { %Person*, i64 }** %l0
  %t2 = call double @total_years({ %Person*, i64 }* %t1)
  ret double %t2
}

define double @Persontotal(%Person %self) {
block.entry:
  %t0 = extractvalue %Person %self, 0
  ret double %t0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
