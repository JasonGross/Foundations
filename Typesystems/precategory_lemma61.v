Add Rec LoadPath "../Generalities".
Add Rec LoadPath "../hlevel1".
Add Rec LoadPath "../hlevel2".
Add Rec LoadPath "../Proof_of_Extensionality".

Require Import basic_lemmas_which_should_be_in_uu0.
Require Import uu0.
Require Import hProp.
Require Import hSet.

Require Import AXIOM_dep_funext.

Require Import precategories.
Require Import precategory_whiskering.

Notation "a == b" := (paths a b) (at level 70, no associativity).
Notation "! p " := (pathsinv0 p) (at level 50).
Notation "p @ q" := (pathscomp0 p q) (at level 60, right associativity).

Ltac pathvia b := (apply (@pathscomp0 _ _ b _ )).

Local Notation "a --> b" := (precategory_morphisms a b)(at level 50).
(*Local Notation "'hom' C" := (precategory_morphisms (C := C)) (at level 2).*)
Local Notation "f ;; g" := (precategory_compose f g)(at level 50).
Notation "[ C , D ]" := (precategory_fun_precategory C D).
Local Notation "# F" := (precategory_ob_mor_fun_morphisms F)(at level 3).


Section lemma61.

Variables A B C : precategory.
Variable H : precategory_objects [A, B].
Hypothesis p : essentially_surjective H.
Hypothesis Hff : fully_faithful H.


Variables F G : precategory_objects [B, C].


Section preimage.

Variable gamma : F O H --> G O H.


Lemma claim1_isinhabited (b : precategory_objects B) : 
    isaprop (total2 (fun g : pr1 F b --> pr1 G b => 
      forall a : precategory_objects A, forall f : iso_precat (pr1 H a) b,
           pr1 gamma a == #(pr1 F) f ;; g ;; #(pr1 G) (inv_from_iso f))).
Proof.
  apply invproofirrelevance.
  intros x x'.
  destruct x as [g q].
  destruct x' as [g' q'].
  assert (Hgg' : g == g'). Focus 1.
  set (pbg := p b (tpair (fun x => isaprop x) (g == g') (pr2 (pr1 F b --> pr1 G b) _ _ ))).
  simpl in pbg.
  apply pbg.
  intro anoth.
  destruct anoth as [anot h].
  set (qanoth := q anot h).
  assert (H1 : g == iso_inv_from_iso (precategory_fun_on_iso _ _ F _ _ h) ;; 
                      pr1 gamma anot ;; precategory_fun_on_iso _ _ G _ _ h).
  apply (pre_comp_with_iso_is_inj _ _ _ _ (precategory_fun_on_iso _ _ F _ _ h)
                                          (pr2 (precategory_fun_on_iso _ _ F _ _ h))).
                                          
  repeat rewrite precategory_assoc.
     rewrite iso_inv_after_iso. rewrite precategory_id_left.
  apply ( post_comp_with_iso_is_inj _ _ _  
          (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h))
                     (pr2 (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h)))).
                     simpl.
  set (H3 :=  base_paths _ _ (precategory_fun_on_iso_inv _ _ G _ _ h)).
  simpl in H3.
  rewrite <- H3.
  repeat rewrite <- precategory_assoc.
  rewrite <- precategory_fun_comp.
  rewrite iso_inv_after_iso.
  rewrite precategory_fun_id.
  rewrite precategory_id_right.
  apply pathsinv0.
  rewrite precategory_assoc.
  apply qanoth.
  
  set (q'anoth := q' anot h).
  
  assert (H2 : g' == iso_inv_from_iso (precategory_fun_on_iso _ _ F _ _ h) ;; 
                      pr1 gamma anot ;; precategory_fun_on_iso _ _ G _ _ h).
  apply (pre_comp_with_iso_is_inj _ _ _ _ (precategory_fun_on_iso _ _ F _ _ h)
                                          (pr2 (precategory_fun_on_iso _ _ F _ _ h))).
                                          
  repeat rewrite precategory_assoc.
     rewrite iso_inv_after_iso. rewrite precategory_id_left.
  apply ( post_comp_with_iso_is_inj _ _ _  
          (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h))
                     (pr2 (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h)))).
                     simpl.
  set (H3 :=  base_paths _ _ (precategory_fun_on_iso_inv _ _ G _ _ h)).
  simpl in H3.
  rewrite <- H3.
  repeat rewrite <- precategory_assoc.
  rewrite <- precategory_fun_comp.
  rewrite iso_inv_after_iso.
  rewrite precategory_fun_id.
  rewrite precategory_id_right.
  apply pathsinv0.
  rewrite precategory_assoc.
  apply q'anoth.
  rewrite H1.
  rewrite H2.
  apply idpath.

  apply (total2_paths2 Hgg').
  apply proofirrelevance.
  apply impred. intro a.
  apply impred. intro a'.
  Check (pr1 gamma a).
  apply (pr2 (pr1 (F O H) a --> pr1 (G O H) a)).
Qed.
  

(*

inv_from_iso_precateory_fun_on_iso.
  apply bla.
                                           

     simpl.

    
  simpl.

Definition claim1_center (F G : precategory_objects [B, C]) (gamma : F O H --> G O H) 
        (b : precategory_objects B) : 
   total2 (fun g : pr1 F b --> pr1 G b => 
      forall a : precategory_objects A, forall f : iso_precat (pr1 H a) b,
           pr1 gamma a == #(pr1 F) f ;; g ;; #(pr1 G) (inv_from_iso f)  ).
Proof.
  set (X := isapropiscontr (total2
     (fun g : (pr1 F) b --> (pr1 G) b =>
      forall (a : precategory_objects A) (f : iso_precat ((pr1 H) a) b),
      pr1 gamma a == (#(pr1 F) f;; g);; #(pr1 G) (inv_from_iso f)))).
  set (pbX := p b (tpair (fun x => isaprop x) _ X)).
  simpl.
  apply pbX. clear pbX. simpl. clear X.
  intro anoth.
  destruct anoth as [anot h].
  simpl in *.
  set (g := #F (inv_from_iso h) ;; gamma anot ;; #G h).

  assert (gp : forall (a : precategory_objects A) 
                     (f : iso_precat (H a) b),
                 gamma a == #F f ;; g ;; #G (inv_from_iso f)).
  intros a f.
  set (k := iso_from_fully_faithful_reflection _ _ _ Hff _ _ 
             (iso_comp f (iso_inv_from_iso h))).
  set (GHk := precategory_fun_on_iso _ _ G _ _ 
                (precategory_fun_on_iso _ _ H _ _ k)).
  pathvia (#F (#H k) ;; gamma anot ;; iso_inv_from_iso GHk).
  
  set (P := post_comp_with_iso_is_inj _ _ _ GHk (pr2 GHk)).
  apply P.
  rewrite <- precategory_assoc.
  change (iso_inv_from_iso GHk ;; GHk) with (inv_from_iso GHk ;; GHk).
  rewrite iso_after_iso_inv. rewrite precategory_id_right.
  set (Hgamma := precategory_fun_fun_ax _ _ gamma).
  simpl in Hgamma.
  rewrite Hgamma. apply idpath.
  unfold GHk.
  rewrite <- precategory_fun_on_iso_inv.
  unfold k. simpl.
  rewrite precategory_fun_on_iso_iso_from_fully_faithful_reflection.
  set (Hr := iso_inv_of_iso_comp _ _ _ _ f (iso_inv_from_iso h)).
  simpl in Hr. 
  set (Hrp := base_paths _ _ Hr). simpl in Hrp.
  rewrite Hrp.
  rewrite precategory_fun_comp.
  set (H3 := homotweqinvweq (weq_from_fully_faithful _ _ _ Hff a anot)).
  simpl in H3. unfold fully_faithful_inv_hom.
  simpl. rewrite H3. clear H3.
  set (H4 := base_paths _ _ (iso_inv_iso_inv _ _ _ h)).
  simpl in H4. rewrite H4.
  rewrite precategory_fun_comp.
  unfold g.
  repeat rewrite precategory_assoc.
  apply idpath.
  
  exists g.

*)

Lemma claim1 (*F G : precategory_objects [B, C]) (gamma : F O H --> G O H) *)
        (b : precategory_objects B) : 
   iscontr (total2 (fun g : pr1 F b --> pr1 G b => 
      forall a : precategory_objects A, forall f : iso_precat (pr1 H a) b,
           pr1 gamma a == #(pr1 F) f ;; g ;; #(pr1 G) (inv_from_iso f)  )).
Proof.
  Check isapropiscontr.
  set (X := isapropiscontr (total2
     (fun g : (pr1 F) b --> (pr1 G) b =>
      forall (a : precategory_objects A) (f : iso_precat ((pr1 H) a) b),
      pr1 gamma a == (#(pr1 F) f;; g);; #(pr1 G) (inv_from_iso f)))).
  set (pbX := p b (tpair (fun x => isaprop x) _ X)).
  simpl.
  apply pbX. clear pbX. simpl. clear X.
  intro anoth.
  destruct anoth as [anot h].
  simpl in *.
  set (g := #F (inv_from_iso h) ;; gamma anot ;; #G h).

  assert (gp : forall (a : precategory_objects A) 
                     (f : iso_precat (H a) b),
                 gamma a == #F f ;; g ;; #G (inv_from_iso f)).
  intros a f.
  set (k := iso_from_fully_faithful_reflection _ _ _ Hff _ _ 
             (iso_comp f (iso_inv_from_iso h))).
  set (GHk := precategory_fun_on_iso _ _ G _ _ 
                (precategory_fun_on_iso _ _ H _ _ k)).
  pathvia (#F (#H k) ;; gamma anot ;; iso_inv_from_iso GHk).
  
  set (P := post_comp_with_iso_is_inj _ _ _ GHk (pr2 GHk)).
  apply P.
  rewrite <- precategory_assoc.
  change (iso_inv_from_iso GHk ;; GHk) with (inv_from_iso GHk ;; GHk).
  rewrite iso_after_iso_inv. rewrite precategory_id_right.
  set (Hgamma := precategory_fun_fun_ax _ _ gamma).
  simpl in Hgamma.
  rewrite Hgamma. apply idpath.
  unfold GHk.
  rewrite <- precategory_fun_on_iso_inv.
  unfold k. simpl.
  rewrite precategory_fun_on_iso_iso_from_fully_faithful_reflection.
  set (Hr := iso_inv_of_iso_comp _ _ _ _ f (iso_inv_from_iso h)).
  simpl in Hr. 
  set (Hrp := base_paths _ _ Hr). simpl in Hrp.
  rewrite Hrp.
  rewrite precategory_fun_comp.
  set (H3 := homotweqinvweq (weq_from_fully_faithful _ _ _ Hff a anot)).
  simpl in H3. unfold fully_faithful_inv_hom.
  simpl. rewrite H3. clear H3.
  set (H4 := base_paths _ _ (iso_inv_iso_inv _ _ _ h)).
  simpl in H4. rewrite H4.
  rewrite precategory_fun_comp.
  unfold g.
  repeat rewrite precategory_assoc.
  apply idpath.
  Search  ( _ -> iscontr _ ).
  apply iscontraprop1.
  apply claim1_isinhabited.
  
  exists g.
  apply gp.
Qed.
  
 
Definition pdelta : forall b : precategory_objects B, pr1 F b --> pr1 G b :=
         fun b => pr1 (pr1 (claim1 b)).
(*
Notation delta := preimage_pre_whisker.
*)
Lemma is_precategory_fun_fun_pdelta : 
     is_precategory_fun_fun (pr1 F) (pr1 G) pdelta.
Proof.
  intros b b' f.
  apply pathsinv0. Check (#(pr1 F) f;; pdelta b').
  set (pb1 := p b (tpair (fun x => isaprop x) 
                       (pdelta b;; #(pr1 G) f == 
                         #(pr1 F) f;; pdelta b')
                       (pr2 ((pr1 F) b --> (pr1 G) b') _ _ ))).
  simpl in *.
  apply pb1. clear pb1.
  intro t; destruct t as [a h].
  set (pb1 := p b' (tpair (fun x => isaprop x) 
                       (pdelta b;; # (G) f == 
                         #(pr1 F) f;; pdelta b')
                       (pr2 ((pr1 F) b --> (pr1 G) b') _ _ ))).
  simpl in *.
  apply pb1. clear pb1.
  intro t; destruct t as [a' h'].
  
  set (k := fully_faithful_inv_hom _ _ H Hff _ _ 
             (h ;; (f ;; (iso_inv_from_iso h')))).
  
  set (gq := pr1 (claim1 b)). 
  set (g := pr1 gq).
  set (q := pr2 gq). simpl in *. unfold gq in *.
  (*destruct gq as [g q].
(*  unfold pdelta. *)*)
  
  set (HH := (q a h)). simpl in *.
  
  assert (Hb : pdelta b == inv_from_iso (precategory_fun_on_iso _ _ F _ _ h) ;; 
                                gamma a ;; #G h).
  apply (pre_comp_with_iso_is_inj _ _ _ _ (precategory_fun_on_iso _ _ F _ _ h)
                                          (pr2 (precategory_fun_on_iso _ _ F _ _ h))).
  repeat rewrite precategory_assoc.
     rewrite iso_inv_after_iso. rewrite precategory_id_left.
  apply ( post_comp_with_iso_is_inj _ _ _  
          (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h))
                     (pr2 (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h)))).
                     simpl.
  set (H3 :=  base_paths _ _ (precategory_fun_on_iso_inv _ _ G _ _ h)).
  simpl in H3.
  rewrite <- H3.
  repeat rewrite <- precategory_assoc.
  rewrite <- precategory_fun_comp.
  rewrite iso_inv_after_iso.
  rewrite precategory_fun_id.
  rewrite precategory_id_right.
  apply pathsinv0.
  clear H3.
  rewrite precategory_assoc.
  apply HH.
  
  
  assert (Hb' : pdelta b' == inv_from_iso (precategory_fun_on_iso _ _ F _ _ h') ;; 
                                gamma a' ;; #G h').
  apply (pre_comp_with_iso_is_inj _ _ _ _ (precategory_fun_on_iso _ _ F _ _ h')
                                          (pr2 (precategory_fun_on_iso _ _ F _ _ h'))).
  repeat rewrite precategory_assoc.
     rewrite iso_inv_after_iso. rewrite precategory_id_left.
  apply ( post_comp_with_iso_is_inj _ _ _  
          (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h'))
                     (pr2 (iso_inv_from_iso (precategory_fun_on_iso _ _ G _ _ h')))).
                     simpl.
  set (H3 :=  base_paths _ _ (precategory_fun_on_iso_inv _ _ G _ _ h')).
  simpl in H3.
  rewrite <- H3.
  repeat rewrite <- precategory_assoc.
  rewrite <- precategory_fun_comp.
  rewrite iso_inv_after_iso.
  rewrite precategory_fun_id.
  rewrite precategory_id_right.
  apply pathsinv0.
  clear H3.
  rewrite precategory_assoc.
  set (gq' := pr1 (claim1 b')).
  set (q' := pr2 gq').
  set (HH' := q' a' h').
  apply HH'.
  
  rewrite Hb.
  repeat rewrite <- precategory_assoc.
  simpl in *.
  rewrite <- (precategory_fun_comp _ _ G _ _ _ h f).
  clear HH q g gq.
  pathvia (inv_from_iso (precategory_fun_on_iso B C F (H a) b h);;
       (gamma a;; #G (h;; f ;; iso_inv_from_iso h' ;; h')) ).
    repeat rewrite <- precategory_assoc.
    simpl. rewrite iso_after_iso_inv. 
           rewrite precategory_id_right.
           apply idpath.
  repeat rewrite precategory_assoc.
  rewrite (precategory_fun_comp _ _ G).
  set (P := precategory_fun_fun_ax _ _ gamma _ _ k). simpl in *.
      unfold k in P. simpl in P.
  set (H3 := homotweqinvweq (weq_from_fully_faithful _ _ _ Hff a a')).
  simpl in H3. 
  unfold fully_faithful_inv_hom in P. simpl in P.
  rewrite H3 in P.
  repeat rewrite <- precategory_assoc.
  rewrite (precategory_assoc _ _ _ _ _ (gamma a)).
  simpl in *.
  rewrite <- P.
  clear H3 P.
  set (H4 := precategory_fun_on_iso_inv _ _ F _ _ h).
  set (H5 := base_paths _ _ H4). simpl in H5.
  rewrite <- H5.
  repeat rewrite precategory_assoc.
  rewrite <- (precategory_fun_comp _ _ F).
  repeat rewrite precategory_assoc.
  rewrite iso_after_iso_inv.
  rewrite precategory_id_left.
  rewrite (precategory_fun_comp _ _ F).
  rewrite precategory_fun_on_inv_from_iso.
  apply pathsinv0.
  rewrite Hb'.
  repeat rewrite precategory_assoc.
  apply idpath.
Qed.


Definition delta : F --> G.
Proof.
  exists pdelta.
  apply is_precategory_fun_fun_pdelta.
Defined.

Lemma pdelta_preimage : pre_whisker _ _ _ H _ _ delta == gamma.
Proof.
  simpl in *.
  apply precategory_fun_fun_eq.
  intro a.
  unfold pre_whisker.
  simpl.
  set (tr := pr1 (claim1 (H a))).
  set (g := pr1 tr).
  set (q := pr2 tr).
  simpl in *. 
  set (gaid := q a (identity_iso_precat a)).
  





