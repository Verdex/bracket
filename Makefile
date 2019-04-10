
all: data.cmi lexer.cmx
	ocamlopt -o bracket lexer.cmx  
# ocamlopt -o bracket *.cmx

lexer.cmx:
	ocamlc -c lexer.mli
	ocamlopt -c lexer.ml

data.cmi: 
	ocamlopt -c data.mli

clean:
	rm -rf *.cmi
	rm -rf *.cmx
	rm -rf *.o
	rm -rf bracket


