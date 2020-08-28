same(X,Y,XRs,YRs) :-
        def(X,D),
        def(Y,D),
        X@<Y,
        findall(XR,def_xref(X,XR),XRs),
        findall(YR,def_xref(Y,YR),YRs).

