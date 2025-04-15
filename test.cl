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
            let num: Int <- 42 in
            let txt: String <- "Hello\nWorld\tTabbed!" in
            let flag: Bool <- false in

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

            new Test;
            not flag;
            ~5;

            -- String length
            
        }
    };
};


-- ERROR TESTS SECTION

(* UNCLOSED COMMENT
class Broken {
*)  -- should cause unclosed comment error

"Unclosed string literal  
-- missing ending quote, should cause error

"String with bad escape: \q"  -- invalid escape sequence

let bad <- 100 in  -- missing type declaration (should be let bad : Int <- 100)

if true then
    out_string("if block")
-- missing 'else' and 'fi'

x <- 5 + ;  -- incomplete expression

class class inherits Int { }  -- 'class' used as an identifier (should be error)

0abc <- 10;  -- invalid identifier (starts with a digit)

let \tweird: String <- "ok";  -- invalid identifier with escape character

"Ends with EOF \0"  -- null character not allowed in string

let cross: String <- "This string
spans lines";  -- non-escaped newline in string