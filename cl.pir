# $Id$

=head1 NAME

cl.pir - Set up the package 'COMMON-LISP'

=cut

.sub _init_cl :init

    .local pmc symbol
    .local pmc value

    .local pmc package
    .PACKAGE(package, "COMMON-LISP")
    set_global ["PACKAGES"], "COMMON-LISP", package
    set_global ["PACKAGES"], "CL", package

    .local pmc t
    t = package.'_intern_symbol'("T")                      # Create the T symbol, T meaning true
    t.'_set_value'(t)
    t.'_set_package'(package)
    t.'_set_special'(t)
    set_global ["SYMBOLS"], "T", t                       # Quick alias to T

    .local pmc nil
    nil = package.'_intern_symbol'("NIL")                  # Create the NIL symbol
    nil.'_set_value'(nil)
    nil.'_set_package'(package)
    nil.'_set_special'(t)
    set_global ["SYMBOLS"], "NIL",  nil                  # Quick alias to NIL

    .INTEGER(value,1)
    .DEFVAR(symbol, package, "*GENSYM-COUNTER*", value)

    .DEFVAR(symbol, package, "*PACKAGE*", package)

    .READTABLE(value)
    .DEFVAR(symbol, package, "*READTABLE*", value)

    .local pmc stream
    getstdin stream
    .STREAM(value,stream)
    .DEFVAR(symbol, package, "*STANDARD-INPUT*", value)

    getstdout stream
    stream.'buffer_type'('unbuffered')
    .STREAM(value,stream)
    .DEFVAR(symbol, package, "*STANDARD-OUTPUT*", value)

    .local pmc function   # this is needed in r20641

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "APPLY", _apply)
    .DEFUN(symbol, package, "APPLY", "_apply")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "ATOM", _atom)
    .DEFUN(symbol, package, "ATOM", "_atom")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "BOUNDP", _boundp)
    .DEFUN(symbol, package, "BOUNDP", "_boundp")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "CAR", _car)
    .DEFUN(symbol, package, "CAR", "_car")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "CDR", _cdr)
    .DEFUN(symbol, package, "CDR", "_cdr")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "CHAR", _char)
    .DEFUN(symbol, package, "CHAR", "_char")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "CONS", _cons)
    .DEFUN(symbol, package, "CONS", "_cons")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "EQ", _eq)
    .DEFUN(symbol, package, "EQ", "_eq")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "EVAL", _eval)
    .DEFUN(symbol, package, "EVAL", "_eval")

    .SPECIAL_FORM(symbol, package, "FUNCTION", '_function')

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "GENSYM", _gensym)
    .DEFUN(symbol, package, "GENSYM", "_gensym")

    .SPECIAL_FORM(symbol, package, "IF", '_if')

    .SPECIAL_FORM(symbol, package, "LET", '_let')

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "LIST", _list)
    .DEFUN(symbol, package, "LIST", "_list")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "MOD", _modulus)
    .DEFUN(symbol, package, "MOD", "_modulus")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "NULL", _null)
    .DEFUN(symbol, package, "NULL", "_null")

    .DEFUN(symbol, package, "PRINT", "_print")

    .SPECIAL_FORM(symbol, package, "PROGN", '_progn')

    .SPECIAL_FORM(symbol, package, "QUOTE", '_quote')

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "READ", _read)
    .DEFUN(symbol, package, "READ", "_read")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "READ-DELIMITED-LIST",_read_delimited_list)
    .DEFUN(symbol, package, "READ-DELIMITED-LIST","_read_delimited_list")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "RPLACA", _rplaca)
    .DEFUN(symbol, package, "RPLACA", "_rplaca")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "RPLACD", _rplacd)
    .DEFUN(symbol, package, "RPLACD", "_rplacd")

    .SPECIAL_FORM(symbol, package, "SETQ", '_setq')

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "TYPE-OF", _type_of)
    .DEFUN(symbol, package, "TYPE-OF", "_type_of")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "VALUES", _values)
    .DEFUN(symbol, package, "VALUES", "_values")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "QUIT", _quit)
    .DEFUN(symbol, package, "QUIT", "_quit")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "/", _divide)
    .DEFUN(symbol, package, "/", "_divide")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "-", _subtract)
    .DEFUN(symbol, package, "-", "_subtract")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "*", _multiply)
    .DEFUN(symbol, package, "*", "_multiply")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "+", _add)
    .DEFUN(symbol, package, "+", "_add")

    # VALID_IN_PARROT_0_2_0 .DEFUN(symbol, package, "=", _equal)
    .DEFUN(symbol, package, "=", "_equal")

    .return(1)
.end

.sub _apply
    .param pmc args
    .ASSERT_MINIMUM_LENGTH(args, 2, ERROR_NARGS)

    .local pmc car
    .CAR(car, args)

    .local pmc args_of_func
    .SECOND(args_of_func, args)
    .ASSERT_TYPE(args_of_func, "list")

    .local string type
    type = typeof car
    if type == "LispFunction" goto CAR_IS_FUNCTION
    if type == "LispSymbol"   goto CAR_IS_SYMBOL
    goto INVALID_FUNCTION_NAME

CAR_IS_FUNCTION:
    .tailcall _FUNCTION_CALL(car, args_of_func)

CAR_IS_SYMBOL:
    .local pmc func
    func = car.'_get_function'()                   # Get the function from symbol
    if_null func, INVALID_FUNCTION_NAME          # Throw an error if undefined
    type = typeof func
    # print type
    # print ' for CAR_IS_SYMBOL'
    .tailcall _FUNCTION_CALL(func,args_of_func)

INVALID_FUNCTION_NAME:
    .ERROR_1("undefined-function", "%s is not a function name", car)
    goto DONE

ERROR_NARGS:
    .ERROR_0("program-error", "wrong number of arguments to APPLY")
    goto DONE

ERROR_NONLIST:
    .ERROR_0("type-error", "second argument to APPLY must be a proper list")
     goto DONE

DONE:
    .return()                                   # Call the return continuation
.end

.sub _atom
  .param pmc args
  .local string type
  .local pmc retv
  .local pmc a

  .ASSERT_LENGTH(args, 1, ERROR_NARGS)

  .CAR(a, args)

   type = typeof a                             # An atom is anything that is
   if type != "LispCons" goto ATOM            # not a cons.
   goto CONS

ATOM:
  .TRUE(retv)
   goto DONE

CONS:
  .NIL(retv)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to ATOM")
   goto DONE

DONE:
  .return(retv)
.end

.sub _boundp
  .param pmc args
  .local pmc symbol
  .local pmc retv
  .local pmc val

  .ASSERT_LENGTH(args, 1, ERROR_NARGS)

  .CAR(symbol, args)
  .ASSERT_TYPE(symbol, "symbol")

   val = symbol.'_get_value'()
   if_null val, UNBOUND

  .TRUE(retv)
   goto DONE

UNBOUND:
  .NIL(retv)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to BOUNDP")
   goto DONE

DONE:
  .return(retv)
.end

.sub _car
  .param pmc args
  .local pmc retv
  .local pmc a

  .ASSERT_LENGTH(args, 1, ERROR_NARGS)

  .CAR(a, args)
  .ASSERT_TYPE(a, "list")

  .CAR(retv, a)

   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to CAR")
   goto DONE

DONE:
  .return(retv)
.end

.sub _cdr
  .param pmc args
  .local pmc retv
  .local pmc a

  .ASSERT_LENGTH(args, 1, ERROR_NARGS)

  .CAR(a, args)
  .ASSERT_TYPE(a, "list")

  .CDR(retv, a)

   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to CDR")
   goto DONE

DONE:
  .return(retv)
.end

.sub _char
 .param pmc args

 .local pmc retval
 .local pmc ke
 .local string str
 .local string sstr
 .local int k
 .local int leng

 .ASSERT_LENGTH(args, 2, ERROR_NARGS)

  str = args[0]
  ke = args[1]
  k = ke[0]

  length leng, str

  if k > leng goto BOUNDS
  if k < 0 goto BOUNDS

  sstr = substr str, k, 1
  retval = new 'LispString'
  retval = sstr
  goto DONE

BOUNDS:
 .NIL(retval)
  goto DONE

ERROR_NARGS:
 .ERROR_0("program-error", "wrong number of arguments to CHAR")
  goto DONE

DONE:
 .return(retval)
.end

.sub _cons
  .param pmc args
  .local pmc retv
  .local pmc a
  .local pmc b

  .ASSERT_LENGTH(args, 2, ERROR_NARGS)

  .CAR(a, args)
  .SECOND(b, args)

  .CONS(retv, a, b)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to CONS")
   goto DONE

DONE:
  .return(retv)
.end

.sub _eq
  .param pmc args
  .local pmc retv
  .local pmc a
  .local pmc b

  .ASSERT_LENGTH(args, 2, ERROR_NARGS)

  .CAR(a, args)
  .SECOND(b, args)

   eq_addr a, b, EQUAL
   goto NOT_EQUAL

EQUAL:
  .TRUE(retv)
   goto DONE

NOT_EQUAL:
  .NIL(retv)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to EQ")
   goto DONE

DONE:
  .return(retv)
.end

.sub _function
    .param pmc args
    .ASSERT_LENGTH(args, 1, ERROR_NARGS)

    .local pmc form
    .CAR(form, args)

    .local pmc retv

    .local string type
    type = typeof form
    if type == "LispSymbol" goto SYMBOL          # Retrieve function from symbol

    .local int is_lambda_list
    is_lambda_list = _IS_ORDINARY_LAMBDA_LIST(form)        # Check if it's a lambda form
    if is_lambda_list goto LAMBDA_FORM                     # and build a closure if so

    goto INVALID_FUNCTION_NAME

SYMBOL:
    .local string symname
    symname = form.'_get_name_as_string'()         # Retrieve the symbols name

    .local pmc package
    package = form.'_get_package'()                # Retrieve the symbols package name
    .local string pkgname
    pkgname = package.'_get_name_as_string'()

    .local pmc symbol
    symbol = _LOOKUP_GLOBAL(pkgname, symname)    # Lookup the symbol

    .local int found
    found = defined symbol                       # Ensure the symbol was found in
    unless found goto FUNCTION_NOT_FOUND         # the global namespace

    retv = symbol.'_get_function'()                # Ensure the symbol had a function
    defined found, symbol                        # defined
    unless found goto FUNCTION_NOT_FOUND

    goto DONE

LAMBDA_FORM:
    retv = _MAKE_LAMBDA(form)                    # Create a closure PMC
    goto DONE

INVALID_FUNCTION_NAME:
    .ERROR_1("undefined-function", "%s is not a function name", form)
    goto DONE

FUNCTION_NOT_FOUND:
    .ERROR_1("undefined-function", "the function %s is undefined", symname)
    goto DONE

ERROR_NARGS:
    .ERROR_0("program-error", "wrong number of arguments to FUNCTION")
    goto DONE

DONE:
    .return(retv)
.end

.sub _gensym
  .param pmc args
  .local string prefix
  .local string gname
  .local pmc suffix
  .local pmc symbol
  .local pmc garg
  .local pmc gcnt
  .local pmc retv
  .local pmc car

  .ASSERT_LENGTH_BETWEEN(args, 0, 1, ERROR_NARGS)

   symbol = _LOOKUP_GLOBAL("COMMON-LISP", "*GENSYM-COUNTER*")
   gcnt = symbol.'_get_value'()

   suffix = gcnt
   prefix = "G"

  .NULL(args, MAKE_SYMBOL)

  .CAR(car, args)
   goto CHECK_PREFIX

CHECK_PREFIX:
  .ASSERT_TYPE_AND_BRANCH(car, "string", CHECK_SUFFIX)
   prefix = car
   goto MAKE_SYMBOL

CHECK_SUFFIX:
  .ASSERT_TYPE(car, "integer")
   if car < 0 goto ERROR_NEGINT
   suffix = car
   goto MAKE_SYMBOL

MAKE_SYMBOL:
   garg = new 'Array'
   garg = 2
   garg[0] = prefix
   garg[1] = suffix

   sprintf gname, "%s%0.6d", garg
   retv = _SYMBOL(gname)

   inc gcnt
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to GENSYM")
  goto DONE

ERROR_NEGINT:
  .ERROR_1("program-error", "%d is negative", car)
   goto DONE

DONE:
  .return(retv)
.end

.sub _if
  .param pmc args
  .local pmc retv
  .local pmc form
  .local pmc earg

  .ASSERT_LENGTH_BETWEEN(args, 2, 3, ERROR_NARGS)

  .CAR(form, args)                      # Get the test form

  .LIST_1(earg,form)
   retv = _eval(earg)                   # Evaluate the test form.

  .NULL(retv, ELSE_CLAUSE)              # If test was false, goto else clause
   goto THEN_CLAUSE                     #else goto then clause

THEN_CLAUSE:
  .SECOND(form, args)

  .LIST_1(earg, form)
   retv = _eval(earg)
   goto DONE

ELSE_CLAUSE:
  .THIRD(form, args)

  .LIST_1(earg, form)
   retv = _eval(earg)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to IF")
   goto DONE

DONE:
  .return(retv)
.end

.sub _list
  .param pmc args
  .local pmc lptr
  .local pmc targ
  .local pmc retv
  .local pmc retp
  .local pmc cons
  .local pmc nil

  .NIL(retv)
  .NIL(nil)

   lptr = args
LOOP:
  .NULL(lptr, DONE)

  .CAR(targ, lptr)

  .NULL(retv, EMPTY_LIST)

  .CONS(cons, targ, nil)
   retp[1] = cons
   retp = cons

EMPTY_LIST_RETURN:
  .CDR(lptr, lptr)
   goto LOOP

EMPTY_LIST:
  .CONS(retv, targ, nil)
   retp = retv
   goto EMPTY_LIST_RETURN

DONE:
  .return(retv)
.end

.sub _null
  .param pmc args
  .local pmc retv
  .local pmc a

  .ASSERT_LENGTH(args, 1, ERROR_NARGS)

  .CAR(a, args)

  .NULL(a, IS_NULL)

  .NIL(retv)
   goto DONE

IS_NULL:
  .TRUE(retv)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to NULL")
   goto DONE

DONE:
  .return(retv)
.end

.sub _let
    .param pmc args
    .ASSERT_MINIMUM_LENGTH(args, 1, ERROR_NARGS)

    .local string name
    .local string type
    .local pmc package
    .local pmc symbol
    .local pmc value
    .local pmc fargs
    .local pmc init
    .local pmc body
    .local pmc lptr
    .local pmc form
    .local int test
    .local int i

    # VALID_IN_PARROT_0_2_0 new_pad -1                    # Create new lexical scope

    .CAR(init, args)                             # The variable bindings
    .CDR(body, args)                             # The form to evaluate

    .local pmc keyvals
    keyvals = new 'ResizablePMCArray'              # List for holding init values
    .local pmc dynvars
    dynvars = new 'ResizablePMCArray'              # List for holding dynamic vars

    # for exception handling, currently broken
    .local pmc error
    null error
    push_eh CLEANUP_HANDLER                      # Set a handler for cleanup

    .local pmc retv
    .NIL(retv)                                   # Initialize return value

INIT_FORM:                                       # Process the init form
    type = typeof init
    if type == "LispSymbol" goto INIT_SYMBOL
    if type == "LispCons"   goto INIT_LIST
    goto EVAL_BODY

INIT_SYMBOL:
    push keyvals, init                          # Init form was just a symbol -
    null value                                  # no value is assigned to it
    push keyvals, value

    goto INIT_DONE

INIT_LIST:
    lptr = init
    goto INIT_LIST_LOOP

INIT_LIST_LOOP:
    .NULL(lptr, INIT_DONE)

    .CAR(form, lptr)                              # Get the next init form

    .ASSERT_TYPE_AND_BRANCH(form, "list", ERROR_BAD_SPEC)
    # VALID_IN_PARROT_0_2_0 .ASSERT_LENGTH(form, 2, ERROR_BADSPEC)                # Ensure a valid init form
    .ASSERT_LENGTH(form, 2, ERROR_BAD_SPEC)       # Ensure a valid init form

    .CAR(symbol, form)                            # The symbol we're assigning to
    .SECOND(value, form)                          # The value being assigned

    .ASSERT_TYPE_AND_BRANCH(symbol, "symbol", ERROR_BAD_SPEC)

    .LIST_1(fargs, value)                         # Put value into an arg list
     value = _eval(fargs)                         # Evaluate it

     push keyvals, symbol                         # Push symbol onto key/val list
     push keyvals, value                          # Push value onto key/val list

    .CDR(lptr, lptr)
     goto INIT_LIST_LOOP

INIT_DONE:

    # bind the variables in init
    .local int nvar
    nvar = keyvals
    i = 0
BIND_LOOP:
    if i >= nvar goto BIND_DONE

    symbol = keyvals[i]                          # Pop symbol of key/val list
    inc i
    value  = keyvals[i]                          # Pop value of key/val list

    name = symbol.'_get_name_as_string'()

    test = _IS_SPECIAL(symbol)
    if test == 0 goto BIND_LEXICAL
    goto BIND_DYNAMIC

BIND_LEXICAL:
    # TODO: replace push_pad, pop_pad, do not worry about closures yet
    symbol = _LEXICAL_SYMBOL(name, value)        # Create a new lexical symbol
    inc i
    goto BIND_LOOP

BIND_DYNAMIC:
    package = symbol.'_get_package'()              # Get dynamic symbols package

    symbol = package.'_shadow_symbol'(name)        # Shadow the symbol
    symbol.'_set_value'(value)                     # Set the new value

    push dynvars, symbol                         # Keep around for tracking

    inc i
    goto BIND_LOOP

BIND_DONE:
   goto EVAL_BODY


EVAL_BODY:
    lptr = body                                  # Set pointer to the body form

EVAL_LOOP:                                      # Evaluate each form in order
    .NULL(lptr, EVAL_DONE)

    .CAR(form, lptr)                              # Get the next form in the body
    .LIST_1(fargs, form)                          # Put it into an arg list
    retv = _eval(fargs)                          # Evaluate it

    .CDR(lptr, lptr)                              # Get a pointer to next form
    goto EVAL_LOOP

EVAL_DONE:
    goto CLEANUP


CLEANUP_HANDLER:
    .get_results (error)                         # Caught an exception - save it
    goto CLEANUP                                 # and clean up before rethrow

CLEANUP:
    # VALID_IN_PARROT_0_2_0    pop_pad                       # Pop off the lexical scope

    nvar = dynvars
    i = 0

CLEANUP_LOOP:
    if i >= nvar goto CLEANUP_DONE

    symbol  = dynvars[i]                         # Symbol to be unshadowed
    name    = symbol.'_get_name_as_string'()
    package = symbol.'_get_package'()

    package.'_unshadow_symbol'(name)               # Unshadow the symbol

    inc i
    goto CLEANUP_LOOP

CLEANUP_DONE:
    if_null error, DONE                          # Rethrow an exception if we
    rethrow error                                # need to
    goto DONE

CLEANUP_RETHROW:
    rethrow error
    goto DONE

# VALID_IN_PARROT_0_2_0 ERROR_BADSPEC:
ERROR_BAD_SPEC:
    .ERROR_1("program-error", "illegal variable specification %s", form)
    goto CLEANUP

ERROR_NARGS:
    .ERROR_0("program-error", "wrong number of arguments to LET")
    goto CLEANUP

DONE:
    .return(retv)
.end

.sub _print                     # This is just a temporary stand-in - it
    .param pmc args               # doesn't have near enough the amount of
                                # functionality required.
    .local string strval
    .local pmc retv
    .local pmc obj

    .ASSERT_LENGTH(args, 1, ERROR_NARGS)

    .CAR(obj, args)

    strval = obj
    .STRING(retv, obj)
    print retv
    print "\n"

    goto DONE

ERROR_NARGS:
    .ERROR_0("program-error", "wrong number of arguments to PRINT")
    goto DONE

DONE:
    .return(retv)
.end

.sub _progn
  .param pmc args
  .local pmc eform
  .local pmc eargs
  .local pmc lptr
  .local pmc retv

  .NIL(retv)
   lptr = args

FORM_LOOP:
  .NULL(lptr, DONE)

  .CAR(eform, lptr)                     # Create the arg list for eval
  .LIST_1(eargs, eform)

   retv = _eval(eargs)                  # Evaluate form in list

  .CDR(lptr, lptr)                      # Point to next form
  goto FORM_LOOP

DONE:
  .return(retv)
.end

.sub _quit
  .param pmc args

  .ASSERT_LENGTH(args, 0, ERROR_NARGS)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to QUIT")
   goto DONE

DONE:
   end
.end

.sub _quote
  .param pmc args
  .local pmc retv

  .ASSERT_LENGTH(args, 1, ERROR_NARGS)

  .CAR(retv,args)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to QUOTE")
   goto DONE

DONE:
  .return(retv)
.end

.sub _rplaca
  .param pmc args
  .local pmc cons
  .local pmc val

  .ASSERT_LENGTH(args, 2, ERROR_NARGS)

  .CAR(cons, args)
  .SECOND(val, args)

  .ASSERT_TYPE(cons, "cons")

   cons[0] = val                          # Replace the car with val
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to RPLACA")
   goto DONE

DONE:
  .return(cons)
.end

.sub _rplacd
  .param pmc args
  .local pmc cons
  .local pmc val

  .ASSERT_LENGTH(args, 2, ERROR_NARGS)

  .CAR(cons, args)
  .SECOND(val, args)

  .ASSERT_TYPE(cons, "cons")              # Ensure first arg is a cons

   cons[1] = val                          # Replace the cdr with val
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to RPLACD")
   goto DONE

DONE:
  .return(cons)
.end

.sub _setq
  .param pmc args

  .local string name
  .local pmc lexical
  .local pmc symbol
  .local pmc value
  .local pmc retv
  .local pmc lptr
  .local pmc earg

  .ASSERT_EVEN_LENGTH(args, ERROR_NARGS)

   lptr = args                                  # Pointer to the arguments
  .NIL(retv)                                    # Initialize return value

LOOP:
  .NULL(lptr, DONE)                             # If we're at the EOL goto DONE

  .CAR(symbol, lptr)                            # Get the variable to assign to
  .SECOND(value, lptr)                          # Get the value being assigned

  .ASSERT_TYPE(symbol, "symbol")                # Ensure variable is a symbol

   name = symbol.'_get_name_as_string'()          # Get the symbols name
   lexical = _LOOKUP_LEXICAL(name)              # Look for it in lexical env
   if_null lexical, SET_SYMBOL_VALUE

   symbol = lexical                             # Lexical variable was found

SET_SYMBOL_VALUE:
  .LIST_1(earg, value)                          # Evaluate the value form
   retv = _eval(earg)

   symbol.'_set_value'(retv)

  .CDR(lptr, lptr)
  .CDR(lptr, lptr)

   goto LOOP

ERROR_NARGS:
  .ERROR_0("program-error", "odd number of arguments to SETQ")
   goto DONE

DONE:
  .return(retv)
.end

.sub _type_of
  .param pmc args
  .local string type
  .local string name
  .local pmc form
  .local pmc retv
  .local pmc nil

  .ASSERT_LENGTH(args, 1, ERROR_NARGS)

  .CAR(form, args)

   null nil

   type = typeof form

   if type == "LispCons"     goto CONS
   if type == "LispFloat"    goto FLOAT
   if type == "LispFunction" goto FUNCTION
   if type == "LispHash"     goto HASH
   if type == "LispInteger"  goto INTEGER
   if type == "LispMacro"    goto MACRO
   if type == "LispPackage"  goto PACKAGE
   if type == "LispStream"   goto STREAM
   if type == "LispString"   goto STRING
   if type == "LispSymbol"   goto SYMBOL

   goto UNKNOWN_TYPE

CONS:
   name = "CONS"
   goto LOOKUP_SYMBOL

FLOAT:
   name = "FLOAT"
   goto LOOKUP_SYMBOL

FUNCTION:
   name = "FUNCTON"
   goto LOOKUP_SYMBOL

HASH:
   name = "HASH-TABLE"
   goto LOOKUP_SYMBOL

INTEGER:
   name = "INTEGER"
   goto LOOKUP_SYMBOL

MACRO:
   name = "MACRO"
   goto LOOKUP_SYMBOL

PACKAGE:
   name = "PACKAGE"
   goto LOOKUP_SYMBOL

STREAM:
   name = "STREAM"
   goto LOOKUP_SYMBOL

STRING:
   name = "STRING"
   goto LOOKUP_SYMBOL

SYMBOL:
   name = "SYMBOL"
   goto LOOKUP_SYMBOL

UNKNOWN_TYPE:
   name = "UNKNOWN"
   goto LOOKUP_SYMBOL

ERROR_NARGS:
  .ERROR_0("program-error", "odd number of arguments to TYPE-OF")
   goto DONE

LOOKUP_SYMBOL:
   retv = _GLOBAL_SYMBOL("COMMON-LISP", name, nil, nil)
   goto DONE

DONE:
  .return(retv)
.end

.sub _values
  .param pmc args
  .local int size
  .local int llen

   llen = _LIST_LENGTH(args)                    # Get # values we're returning

   $P16 = args                                   # Pointer to argument list

   if llen == 0 goto DONE

   $P5  = $P16[0]
   $P16 = $P16[1]
   if llen == 1 goto DONE

   $P6  = $P16[0]
   $P16 = $P16[1]
   if llen == 2 goto DONE

   $P7  = $P16[0]
   $P16 = $P16[1]
   if llen == 3 goto DONE

   $P8  = $P16[0]
   $P16 = $P16[1]
   if llen == 4 goto DONE

   $P9  = $P16[0]
   $P16 = $P16[1]
   if llen == 5 goto DONE

   $P10 = $P16[0]
   $P16 = $P16[1]
   if llen == 6 goto DONE

   $P11 = $P16[0]
   $P16 = $P16[1]
   if llen == 7 goto DONE

   $P12 = $P16[0]
   $P16 = $P16[1]
   if llen == 8 goto DONE

   $P13 = $P16[0]
   $P16 = $P16[1]
   if llen == 9 goto DONE

   $P14 = $P16[0]
   $P16 = $P16[1]
   if llen == 10 goto DONE

   $P15 = $P16[0]
   $P16 = $P16[1]
   if llen == 11 goto DONE

   size = llen - 11                             # Size of the overflow array

   $P3 = new 'Array'                             # Allocate overflow array
   $P3 = size

  .local pmc elem
  .local int indx

   indx = 0                                     # Initial index into overflow
OVERFLOW_LOOP:
   if indx == size goto DONE_OVERFLOW

   elem = $P16[0]

   $P3[indx] = elem                              # Set next overflow element
   inc indx

   $P16 = $P16[1]                                 # Set next element in list
   goto OVERFLOW_LOOP

DONE_OVERFLOW:
   llen = 11                                    # Only report # retv's in regs
   goto DONE

DONE:
   # VALID_IN_PARROT_0_2_0  is_prototyped = 0                             # Set up return registers

   # VALID_IN_PARROT_0_2_0  argcI = 0
   # VALID_IN_PARROT_0_2_0  argcN = 0
   # VALID_IN_PARROT_0_2_0  argcP = llen
   # VALID_IN_PARROT_0_2_0  argcS = 0

   # VALID_IN_PARROT_0_2_0 returncc
   .return()
.end

.sub _add
  .param pmc args
  .local pmc lptr
  .local pmc targ
  .local pmc retv

  .INTEGER(retv, "0")                           # + with no args should give 0

   lptr = args

LOOP:
  .NULL(lptr, DONE)

  .CAR(targ,lptr)                               # Get the next arg and ensure
  .ASSERT_TYPE(targ, "number")                  # it is numeric.

   retv = retv + targ                           # Add to the running total.

  .CDR(lptr,lptr)
   goto LOOP

DONE:
  .return(retv)
.end

.sub _subtract
  .param pmc args
  .local pmc lptr
  .local pmc targ
  .local pmc retv
  .local int narg

  .ASSERT_MINIMUM_LENGTH(args,1,ERROR_NARGS)

  .CAR(retv,args)                               # Get the first argument and
  .ASSERT_TYPE(retv, "number")                  # ensure it is numeric.

  .CDR(lptr,args)                               # Get a pointer to rest of args
   narg = 1                                     # Number of args encountered

LOOP:
  .NULL(lptr,DONE_LOOP)

  .CAR(targ, lptr)                              # Get the next arg and ensure
  .ASSERT_TYPE(targ, "number")                  # it is numeric.

   retv = retv - targ                           # Subtract from running total.

  .CDR(lptr,lptr)
   inc narg                                     # Increment # args processed
   goto LOOP

DONE_LOOP:
   if narg > 1 goto DONE                        # If we only had one arg return
   neg retv                                     # its negative value
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to -")
   goto DONE

DONE:
  .return(retv)
.end

.sub _multiply
  .param pmc args
  .local pmc lptr
  .local pmc targ
  .local pmc retv

  .INTEGER(retv, "1")                           # + with no args should give 0

   lptr = args

LOOP:
  .NULL(lptr,DONE)

  .CAR(targ,lptr)                               # Get the next arg and ensure
  .ASSERT_TYPE(targ, "number")                  # it is numeric.

   retv = retv * targ                           # Multiply the running product.

  .CDR(lptr,lptr)
   goto LOOP

DONE:
  .return(retv)
.end

.sub _divide
  .param pmc args
  .local pmc lptr
  .local pmc targ
  .local pmc retv
  .local int narg

  .ASSERT_MINIMUM_LENGTH(args,1,ERROR_NARGS)

  .CAR(retv,args)                               # Get the first argument and
  .ASSERT_TYPE(retv, "number")                  # ensure it is numeric.

  .CDR(lptr,args)                               # Get a pointer to rest of args
   narg = 1                                     # Number of args encountered

LOOP:
  .NULL(lptr,DONE_LOOP)

  .CAR(targ,lptr)                               # Get the next arg and ensure
  .ASSERT_TYPE(targ, "number")                  # it is numeric.

   retv = retv / targ                           # Divide the running total.

  .CDR(lptr,lptr)
   inc narg                                     # Increment # args processed
   goto LOOP

DONE_LOOP:
   if narg > 1 goto DONE                        # If we only had one arg, return
  .INTEGER(targ, 1)                             # its inverse
   retv = targ / retv
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to /")
   goto DONE

DONE:
  .return(retv)
.end

.sub _modulus
  .param pmc args
  .local pmc retv
  .local pmc numb
  .local pmc div

  .ASSERT_LENGTH(args, 2, ERROR_NARGS)

  .CAR(numb,args)
  .SECOND(div,args)

  .ASSERT_TYPE(numb, "number")                  # Ensure both of the args are
  .ASSERT_TYPE(div,  "number")                  # numeric.

  .INTEGER(retv,0)

   mod retv, numb, div                          # Compute the modulus
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to MOD")
   goto DONE

DONE:
  .return(retv)
.end

.sub _equal
  .param pmc args
  .local pmc lptr
  .local pmc arg1
  .local pmc arg2
  .local pmc retv

  .ASSERT_MINIMUM_LENGTH(args, 1, ERROR_NARGS)

  .CAR(arg1, args)                              # Get the first argument and
  .ASSERT_TYPE(arg1, "number")                  # ensure it is numeric.

  .CDR(lptr,args)                               # Get a pointer to rest of args

  .TRUE(retv)

LOOP:
  .NULL(lptr, DONE)

  .CAR(arg2, lptr)                              # Get the next arg and ensure
  .ASSERT_TYPE(arg2, "number")                  # it is numeric.

   if arg1 != arg2 goto NOT_EQUAL

  .CDR(lptr, lptr)
   goto LOOP

NOT_EQUAL:
  .NIL(retv)
   goto DONE

ERROR_NARGS:
  .ERROR_0("program-error", "wrong number of arguments to =")
   goto DONE

DONE:
  .return(retv)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
