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

declare noalias i8* @malloc(i64)

@runtime = external global i8**

define { %Person*, i64 }* @make_people() {
entry:
  %t0 = sitofp i64 36 to double
  %t1 = insertvalue %Person undef, double %t0, 0
  %t2 = sitofp i64 42 to double
  %t3 = insertvalue %Person undef, double %t2, 0
  %t4 = alloca [2 x %Person]
  %t5 = getelementptr [2 x %Person], [2 x %Person]* %t4, i32 0, i32 0
  %t6 = getelementptr %Person, %Person* %t5, i64 0
  store %Person %t1, %Person* %t6
  %t7 = getelementptr %Person, %Person* %t5, i64 1
  store %Person %t3, %Person* %t7
  %t8 = alloca { %Person*, i64 }
  %t9 = getelementptr { %Person*, i64 }, { %Person*, i64 }* %t8, i32 0, i32 0
  store %Person* %t5, %Person** %t9
  %t10 = getelementptr { %Person*, i64 }, { %Person*, i64 }* %t8, i32 0, i32 1
  store i64 2, i64* %t10
  ret { %Person*, i64 }* %t8
}

define double @total_years({ %Person*, i64 }* %values) {
entry:
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
  ret double %t16
}

define double @main() {
entry:
  %l0 = alloca { %Person*, i64 }*
  %t0 = call { %Person*, i64 }* @make_people()
  store { %Person*, i64 }* %t0, { %Person*, i64 }** %l0
  %t1 = load { %Person*, i64 }*, { %Person*, i64 }** %l0
  %t2 = call double @total_years({ %Person*, i64 }* %t1)
  ret double %t2
}

define double @Persontotal(%Person %self) {
entry:
  %t0 = extractvalue %Person %self, 0
  ret double %t0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}