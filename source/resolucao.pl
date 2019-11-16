deduce(ctx(H,A),['id']) :- member(A,H).
deduce(ctx(H,A),['and-ee']) :- member(and(A,_),H).
deduce(ctx(H,B),['and-ed']) :- member(and(_,B),H).
deduce(ctx(H,B),['imp-e','id'|R])  :- member(imp(A,B),H), proof(ctx(H,A),R).
deduce(ctx(H,O),['or-e'|R]) :- member(or(A,B),H),proof(ctx([A|H],O),RS),
                                                  proof(ctx([B|H],O),RS1),
                                                  append(RS1,RS,R).

proof(done,[]).
proof(ctx(H,O),['id']) :- member(O,H).
proof(ctx(H,and(A,B)),['and-i'|R]) :- proof(ctx(H,A),RS),
                                      proof(ctx(H,B),RS1),
                                      append(RS,RS1,R).

proof(ctx(H,imp(A,B)),['intro-imp'|RS]) :- proof(ctx([A|H],B),RS).
proof(ctx(H,or(A,_)),['i-or'|RS]) :- proof(ctx(H,A),RS).
proof(ctx(H,or(_,B)),['i-or'|RS]) :- proof(ctx(H,B),RS).
proof(ctx(H,O),RS) :- deduce(ctx(H,O),RS).
proof(ctx(H,A),['RAA'|RS]) :- proof(ctx([imp(A,bot)|H],bot),RS).