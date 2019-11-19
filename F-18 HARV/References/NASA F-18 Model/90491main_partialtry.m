[m,n] = size(alp);
invector;
in = [invect;
      derivout];
baeroout = 0*ones(7,m);
for i = 1:m,
  baeroout(:,i) = partialtilde(in(:,i));
end
