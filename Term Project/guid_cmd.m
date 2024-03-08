function U = guid_cmd()
    A = [-cos(X(5) - psi)*cos(X(6)), X(4)*sin(X(5) - psi)*cos(X(6)), X(4)*cos(X(5) - psi)*sin(X(6));
         -sin(X(6)), 0, -X(4)*cos(X(6));
         -sin(X(5) - psi)*cos(X(6)), X(4)*cos(X(5) - psi)*cos(X(6)), X(4)*sin(X(5) - psi)*sin(X(6))];


    B1 = -k1*(S1)^(n/m) + X(4)*sin(X(5) - psi)*cos(X(6))*psi_d ...
        - Vt_d*cos(X(10) - psi) + X(9)*sin(X(10) - psi)*(alp_t_d - psi_d) ...
        - ka*(X(9)*cos(X(10) - psi) - X(4)*cos(X(6))*cos(X(5) - psi));

    B3 = -Rxy*k2*(S2)^(n/m) - kb*Rxy*(psi_d - alp_t_d) ...
        + alp_t_dd*Rxy + Rxy_d*psi_d - X(4)*cos(X(5) - psi)*cos(X(6))*psi_d ...
        - X(9)*cos(X(10) - psi)*(alp_t_d - psi_d)- Vt_d*sin(X(10) - psi);
    
    B = [B1;
         -k2*(S2)^(n/m) + ka*X(4)*sin(X(6));
         B3];

    U = A\B;
end