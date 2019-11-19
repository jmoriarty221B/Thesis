[m,n] = size(alp);
invector;
in = [invect;
      derivout];
modout = 0*ones(3,m);
for i = 1:m
  modout(:,i) = model(in(:,i));
  i
end
