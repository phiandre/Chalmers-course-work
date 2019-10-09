function engineBrakeForce = EngineBrakeForce(gear)
  Cb = 3000;
  engineBrakeForce = 0;
  switch gear
    case 1
      engineBrakeForce = 7.0*Cb;
    case 2
      engineBrakeForce = 5.0*Cb;
    case 3
      engineBrakeForce = 4.0*Cb;
    case 4
      engineBrakeForce = 3.0*Cb;
    case 5
      engineBrakeForce = 2.5*Cb;
    case 6
      engineBrakeForce = 2.0*Cb;
    case 7
      engineBrakeForce = 1.6*Cb;
    case 8
      engineBrakeForce = 1.4*Cb;
    case 9
      engineBrakeForce = 1.2*Cb;
    case 10
      engineBrakeForce = Cb;
  end
end