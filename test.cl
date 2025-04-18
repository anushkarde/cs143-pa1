(* models one-dimensional cellular automaton on a circle of finite radius
   arrays are faked as Strings,
   X's respresent live cells, dots represent dead cells,
   no error checking is done *)
class CellularAutomaton inherits IO {
    population_map : String;
   
    init(map : String) : SELF_TYPE {
        {
            population_map <- map;
            self;
        }
    };
   
    print() : SELF_TYPE {
        {
            out_string(population_map.concat("\n"));
            self;
        }
    };
   
    num_cells() : Int {
        population_map.length()
    };
   
    cell(position : Int) : String {
        population_map.substr(position, 1)
    };
   
    cell_left_neighbor(position : Int) : String {
        if position = 0 then
            cell(num_cells() - 1)
        else
            cell(position - 1)
        fi
    };
   
    cell_right_neighbor(position : Int) : String {
        if position = num_cells() - 1 then
            cell(0)
        else
            cell(position + 1)
        fi
    };
   
    (* a cell will live if exactly 1 of itself and it's immediate
       neighbors are alive *)
    cell_at_next_evolution(position : Int) : String {
        if (if cell(position) = "X" then 1 else 0 fi
            + if cell_left_neighbor(position) = "X" then 1 else 0 fi
            + if cell_right_neighbor(position) = "X" then 1 else 0 fi
            = 1)
        then
            "X"
        else
            '.'
        fi
    };
   
    evolve() : SELF_TYPE {
        (let position : Int in
        (let num : Int <- num_cells[] in
        (let temp : String in
            {
                while position < num loop
                    {
                        temp <- temp.concat(cell_at_next_evolution(position));
                        position <- position + 1;
                    }
                pool;
                population_map <- temp;
                self;
            }
        ) ) )
    };
};

class Main {
    cells : CellularAutomaton;
   
    main() : SELF_TYPE {
        {
            cells <- (new CellularAutomaton).init("         X         ");
            cells.print();
            (let countdown : Int <- 20 in
                while countdown > 0 loop
                    {
                        cells.evolve();
                        cells.print();
                        countdown <- countdown - 1;
                    
                pool
            );  (* end let countdown *)
            -- Run the Test.main()
            (new Test).main();

            self;

        }
    };
};

-- VALID CODE SECTION

class Test inherits IO {
    main(): Object {
        {
            -- Base Objects
            let num: Int <- 42 in
            let txt: String <- "Hello\nWorld\tTabbed!" in
            let flag: Bool <- false in
            t : T,
            obj : Object,
            str : String,
            int : Int,
            bool : Bool

            -- Keywords
            if isvoid num then
                out_string("Void\n")
            else
                out_int(num + 1)
            fi;

            while num < 100 loop
                num <- num + 1
            pool;

            case flag of
                t: Bool => out_string("True branch\n");
                f: Bool => out_string("False branch\n");
            esac;

            -- String with exactly 1024 chars
            justRight = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
            -- Detect escape sequences
            tab = " \t      \\t"
            backspace = " \b \\b"
            formfeed = "\f "
            newline = "\p = p, \n != \\n"

            -- Testing each portion
            --Integers
            090324
            34194320412389481958193483912483294812394320148932
            34132432 124321423 1234314123
            1234    134 4932143 
            --Different Permutations of Key Words 
            CASE CASe CAsE CAse CaSE CaSe CasE Case cASE cASe cAsE cAse caSE caSe casE case
            IN In iN in
            ISVOID ISVOId ISVOiD ISVOid ISVoID ISVoId ISVoiD ISVoid ISvOID ISvOId ISvOiD ISvOid ISvoID ISvoId ISvoiD ISvoid IsVOID IsVOId IsVOiD IsVOid IsVoID IsVoId IsVoiD IsVoid IsvOID IsvOId IsvOiD IsvOid IsvoID IsvoId IsvoiD Isvoid iSVOID iSVOId iSVOiD iSVOid iSVoID iSVoId iSVoiD iSVoid iSvOID iSvOId iSvOiD iSvOid iSvoID iSvoId iSvoiD iSvoid isVOID isVOId isVOiD isVOid isVoID isVoId isVoiD isVoid isvOID isvOId isvOiD isvOid isvoID isvoId isvoiD isvoid
            LET LEt LeT Let lET lEt leT let
            NEW NEw NeW New nEW nEw neW new
            NOT NOt NoT Not nOT nOt noT not
            POOL POOl POoL POol PoOL PoOl PooL Pool pOOL pOOl pOoL pOol poOL poOl pooL pool
            TRUE TRUe TRuE TRue TrUE TrUe TruE True tRUE tRUe tRuE tRue trUE trUe truE true
            WHILE WHILe WHIlE WHIle WHiLE WHiLe WHilE WHile WhILE WhILe WhIlE WhIle WhiLE WhiLe WhilE While wHILE wHILe wHIlE wHIle wHiLE wHiLe wHilE wHile whILE whILe whIlE whIle whiLE whiLe whilE while
            CLASS CLASs CLAsS CLAss CLaSS CLaSs CLasS CLass ClASS ClASs ClAsS ClAss ClaSS ClaSs ClasS Class cLASS cLASs cLAsS cLAss cLaSS cLaSs cLasS cLass clASS clASs clAsS clAss claSS claSs clasS class
            ELSE ELSe ELsE ELse ElSE ElSe ElsE Else eLSE eLSe eLsE eLse elSE elSe elsE else
            ESAC ESAc ESaC ESac EsAC EsAc EsaC Esac eSAC eSAc eSaC eSac esAC esAc esaC esac
            FALSE FALSe FALsE FALse FAlSE FAlSe FAlsE FAlse FaLSE FaLSe FaLsE FaLse FalSE FalSe FalsE False fALSE fALSe fALsE fALse fAlSE fAlSe fAlsE fAlse faLSE faLSe faLsE faLse falSE falSe falsE false
            FI Fi fI fi
            IF If iF if
            INHERITS INHERITs INHERItS INHERIts INHERiTS INHERiTs INHERitS INHERits INHErITS INHErITs INHErItS INHErIts INHEriTS INHEriTs INHEritS INHErits INHeRITS INHeRITs INHeRItS INHeRIts INHeRiTS INHeRiTs INHeRitS INHeRits INHerITS INHerITs INHerItS INHerIts INHeriTS INHeriTs INHeritS INHerits INhERITS INhERITs INhERItS INhERIts INhERiTS INhERiTs INhERitS INhERits INhErITS INhErITs INhErItS INhErIts INhEriTS INhEriTs INhEritS INhErits INheRITS INheRITs INheRItS INheRIts INheRiTS INheRiTs INheRitS INheRits INherITS INherITs INherItS INherIts INheriTS INheriTs INheritS INherits InHERITS InHERITs InHERItS InHERIts InHERiTS InHERiTs InHERitS InHERits InHErITS InHErITs InHErItS InHErIts InHEriTS InHEriTs InHEritS InHErits InHeRITS InHeRITs InHeRItS InHeRIts InHeRiTS InHeRiTs InHeRitS InHeRits InHerITS InHerITs InHerItS InHerIts InHeriTS InHeriTs InHeritS InHerits InhERITS InhERITs InhERItS InhERIts InhERiTS InhERiTs InhERitS InhERits InhErITS InhErITs InhErItS InhErIts InhEriTS InhEriTs InhEritS InhErits InheRITS InheRITs InheRItS InheRIts InheRiTS InheRiTs InheRitS InheRits InherITS InherITs InherItS InherIts InheriTS InheriTs InheritS Inherits iNHERITS iNHERITs iNHERItS iNHERIts iNHERiTS iNHERiTs iNHERitS iNHERits iNHErITS iNHErITs iNHErItS iNHErIts iNHEriTS iNHEriTs iNHEritS iNHErits iNHeRITS iNHeRITs iNHeRItS iNHeRIts iNHeRiTS iNHeRiTs iNHeRitS iNHeRits iNHerITS iNHerITs iNHerItS iNHerIts iNHeriTS iNHeriTs iNHeritS iNHerits iNhERITS iNhERITs iNhERItS iNhERIts iNhERiTS iNhERiTs iNhERitS iNhERits iNhErITS iNhErITs iNhErItS iNhErIts iNhEriTS iNhEriTs iNhEritS iNhErits iNheRITS iNheRITs iNheRItS iNheRIts iNheRiTS iNheRiTs iNheRitS iNheRits iNherITS iNherITs iNherItS iNherIts iNheriTS iNheriTs iNheritS iNherits inHERITS inHERITs inHERItS inHERIts inHERiTS inHERiTs inHERitS inHERits inHErITS inHErITs inHErItS inHErIts inHEriTS inHEriTs inHEritS inHErits inHeRITS inHeRITs inHeRItS inHeRIts inHeRiTS inHeRiTs inHeRitS inHeRits inHerITS inHerITs inHerItS inHerIts inHeriTS inHeriTs inHeritS inHerits inhERITS inhERITs inhERItS inhERIts inhERiTS inhERiTs inhERitS inhERits inhErITS inhErITs inhErItS inhErIts inhEriTS inhEriTs inhEritS inhErits inheRITS inheRITs inheRItS inheRIts inheRiTS inheRiTs inheRitS inheRits inherITS inherITs inherItS inherIts inheriTS inheriTs inheritS inherits
            LOOP LOOp LOoP LOop LoOP LoOp LooP Loop lOOP lOOp lOoP lOop loOP loOp looP loop
            OF Of oF of
            THEN THEn THeN THen ThEN ThEn TheN Then tHEN tHEn tHeN tHen thEN thEn theN then

            new Test;
            not flag;

            ~5;
            
        }
    };
};

-- ===========================
-- ERROR TESTS: STRINGS
-- ===========================

"Unclosed string literal  
-- missing ending quote, should cause error

"String with bad escape: \q"  -- invalid escape sequence

"Ends with EOF \0"  -- null character not allowed in string

let cross: String <- "This string
spans lines";  -- non-escaped newline in string

-- String with exactly 1025 chars (1 over limit)
oneTooBig = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

-- String with 1026 characters:
twoTooBig = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

-- String with multiple errors:
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
"

-- String with many new lines
"



asjkdfj;dfjsd"

-- String with null

" "

-- ===========================
-- ERROR TESTS: SYNTAX / EXPRESSIONS
-- ===========================

let bad <- 100 in  -- missing type declaration (should be let bad : Int <- 100)

if true then
    out_string("if block")
-- missing 'else' and 'fi'

x <- 5 + ;  -- incomplete expression

-- ===========================
-- ERROR TESTS: IDENTIFIERS / KEYWORDS
-- ===========================

class class inherits Int { }  -- 'class' used as an identifier (should be error)

0abc <- 10;  -- invalid identifier (starts with a digit)

let \tweird: String <- "ok";  -- invalid identifier with escape character

-- ===========================
-- ERROR TESTS: INVALID ASCII CHARACTERS
-- ===========================

∆øßˆß˚¬∆ƒ¬˚ß√ß¬˚  -- non-ASCII characters



-- Identifiers
Hello
_fasjdfkdsfE    -- invalid identifier because it starts with an underscore
fight
friend
fRIE123214
FDASDFr123saf4fx.-ff{}  -- identifier followed by various single characters
1Fredfasd -- invalid identifier because it starts with a integer 

-- all possible single characters
: ; , . @ [ ] { } ( ) => <- + - * / ~ < <= = 

-- Comment inside string
" STRINGSJFKDSAJFKSDJFSDKFJDSKFJSD (* afksdfjasdkfjsdf *)" 
" -- this is a comment inside a string so it shouldn't matter "

-- Testing all types of white space
                            \t \r \n \v \f

-- Single quote stuff
' EHREREJR ' 
'\t'
'\n'

-- Errors: basically, everything else
#$&^>`| %
¢§¶•ªº«»†‡‰⁂⁋←↑→↓↔∞≠∑∏∫∂∇

-- Escape sequences in strings
"\n\n\t\b\p\c\r\\\asfdfd\fdsaf"
"\"
""
"\\\\\"

-- ===========================
-- ERROR TESTS: COMMENTS
-- ===========================

(* UNCLOSED COMMENT
class Broken {
*)  -- should cause unclosed comment error

(*  -- Unterminated comment

(*(*(*(*(*(* *)*)*)*)*)  -- EOF inside nested comment (unbalanced)
-- Comments may also be written by enclosing
-- text in (∗ . . . ∗). The latter form of comment may be nested. Comments cannot cross file boundaries.
(*NESTED COMMENT*) 
(* (* (* SUPER NESTED


 COMMENT *) *) *)

(*(*(*(*(*(* *)*)*)*)*)  -- EOF inside nested comment (unbalanced)