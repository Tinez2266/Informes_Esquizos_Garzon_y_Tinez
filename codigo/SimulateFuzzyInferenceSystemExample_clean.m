open_system('sltank')

rule1 = "If level is okay then valve is no_change";
rule2 = "If level is low then valve is open_fast";
rule3 = "If level is high then valve is close_fast";
rules = [rule1 rule2 rule3];
tank.Rules = fisrule(rules);

open_system('sltank/Comparison')
sim('sltank',100)

rule4 = "If level is okay and rate is positive then valve is close_slow";
rule5 = "If level is okay and rate is negative then valve is open_slow";
newRules = [rule4 rule5];
tank = addRule(tank,newRules);

sim('sltank',100)

open_system('sltankrule')
sim('sltankrule',100)
