function phermoneLevel = InitializePheromoneLevels(numberOfCities, tau0)
  phermoneLevel = ones(numberOfCities, numberOfCities)*tau0;
end