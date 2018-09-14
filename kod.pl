%sesli harfler tanımlanıyor.
sesli_harf('a').
sesli_harf('e').
sesli_harf('I').
sesli_harf('i').
sesli_harf('o').
sesli_harf('O').
sesli_harf('u').
sesli_harf('U').


%Verilen liste boş ise true döner.
notEmpty([_|_]). 


%bir listede aranan elemanın olup olmadığını bulur.
isMember(X,[X|_]).
isMember(X,[_|T]) :- isMember(X,T).


%Verilen kelimenin sessiz harflerini siler.
sessizHarfleriSil([],[]).
sessizHarfleriSil([H|T],[H|R]) :- sesli_harf(H),sessizHarfleriSil(T,R), !.
sessizHarfleriSil([H|T],R) :- sessizHarfleriSil(T,R).


%büyük ünlü uyumu kontrolü
isBuyukUnluUyumu1([]).
isBuyukUnluUyumu1([H|T]) :- isMember(H, ['a','I','o','u']), ! , isBuyukUnluUyumu1(T).

isBuyukUnluUyumu2([]).
isBuyukUnluUyumu2([H|T]) :- isMember(H, ['e','i','O','U']), ! , isBuyukUnluUyumu2(T).

isBuyukUnluUyumu(L) :- sessizHarfleriSil(L,M),  notEmpty(M) ,(isBuyukUnluUyumu1(M) ; isBuyukUnluUyumu2(M)).


%Küçük ünlü uyumu kontrolü
isKucukUnluUyumu1([]).
isKucukUnluUyumu1([H|T]) :- isMember(H, ['a','e','I','i']), ! ,isKucukUnluUyumu1(T).

isKucukUnluUyumu2([]).
isKucukUnluUyumu2([H|T]) :- isMember(H, ['o','O','u','U']), ! , isKucukUnluUyumu3(T).

isKucukUnluUyumu3([]).
isKucukUnluUyumu3([H|T]) :- isMember(H, ['a','e','u','ü']), ! , isKucukUnluUyumu3(T).


isKucukUnluUyumu(L) :- sessizHarfleriSil(L,M), notEmpty(M) ,(isKucukUnluUyumu1(M) ; isKucukUnluUyumu2(M)).


%Değerlendirme aşaması
degerlendir(L) :-  isBuyukUnluUyumu(L) , isKucukUnluUyumu(L),  writeln('Hem buyuk unlu uyumuna hem de kucuk unlu uyumuna uyar.'), !.
degerlendir(L) :-  isBuyukUnluUyumu(L) , not(isKucukUnluUyumu(L)),  writeln('Sadece buyuk unlu uyumuna uyar.'), !.
degerlendir(L) :-  not(isBuyukUnluUyumu(L)) , isKucukUnluUyumu(L),  writeln('Sadece kucuk unlu uyumuna uyar'), !.
degerlendir(L) :-  not(isBuyukUnluUyumu(L)) , not(isKucukUnluUyumu(L)),  writeln('Buyuk unlu uyumuna da kucuk unlu uyumuna da uymaz.').

