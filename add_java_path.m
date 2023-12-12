function add_java_path(op)   

	p0 = 'synquant3d';
	p1 = 'commons-math3-3.6.1.jar';
	if strcmp(op,'add')
		javaaddpath({p0,p1});
	else
		javarmpath(p0,p1);                
	end
	
end
