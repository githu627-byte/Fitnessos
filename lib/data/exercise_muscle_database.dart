/// AUTO-GENERATED EXERCISE MUSCLE DATABASE
/// Contains all 504 exercises with HOW TO instructions and muscle mappings
/// 
/// MUSCLE COLOR CODING:
/// - 0.0 = RED (Primary muscles - heavily targeted)
/// - 0.5-0.6 = ORANGE (Secondary muscles - engaged but not primary)
/// - 1.0 = GREEN (Not targeted)

class ExerciseMuscleData {
  final Map<String, double> primaryMuscles;
  final Map<String, double> secondaryMuscles;
  final String description;

  const ExerciseMuscleData({
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.description,
  });

  Map<String, double> get allMuscles {
    return {...primaryMuscles, ...secondaryMuscles};
  }
}

const Map<String, ExerciseMuscleData> exerciseMuscleDatabase = {
  'squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, toes slightly pointed out. Keep your chest up and core tight. Lower your body by pushing your hips back and bending your knees, as if sitting in a chair. Go down until thighs are parallel to the floor or lower. Keep your knees tracking over your toes. Push through your heels to drive back up to standing, squeezing your glutes at the top.',
  ),
  'squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, toes slightly pointed out. Keep your chest up and core tight. Lower your body by pushing your hips back and bending your knees, as if sitting in a chair. Go down until thighs are parallel to the floor or lower. Keep your knees tracking over your toes. Push through your heels to drive back up to standing, squeezing your glutes at the top.',
  ),
  'air_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, arms extended in front or crossed over chest. Keeping your chest proud, push your hips back and bend your knees to lower into a squat. Descend until thighs are at least parallel to the floor. Keep your weight on your heels and knees aligned with toes. Drive through your heels to return to standing.',
  ),
  'air_squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, arms extended in front or crossed over chest. Keeping your chest proud, push your hips back and bend your knees to lower into a squat. Descend until thighs are at least parallel to the floor. Keep your weight on your heels and knees aligned with toes. Drive through your heels to return to standing.',
  ),
  'bodyweight_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, arms extended in front or crossed over chest. Keeping your chest proud, push your hips back and bend your knees to lower into a squat. Descend until thighs are at least parallel to the floor. Keep your weight on your heels and knees aligned with toes. Drive through your heels to return to standing.',
  ),
  'bodyweight_squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, arms extended in front or crossed over chest. Keeping your chest proud, push your hips back and bend your knees to lower into a squat. Descend until thighs are at least parallel to the floor. Keep your weight on your heels and knees aligned with toes. Drive through your heels to return to standing.',
  ),
  'squats_bw': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, arms extended in front or crossed over chest. Keeping your chest proud, push your hips back and bend your knees to lower into a squat. Descend until thighs are at least parallel to the floor. Keep your weight on your heels and knees aligned with toes. Drive through your heels to return to standing.',
  ),
  'goblet_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Hold a dumbbell or kettlebell vertically at chest height with both hands cupping the top weight. Stand with feet shoulder-width apart. Keep the weight close to your chest with elbows pointing down. Squat down by pushing hips back and bending knees, keeping your chest up. Go as deep as possible while maintaining form. Push through heels to return to start.',
  ),
  'goblet_squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Hold a dumbbell or kettlebell vertically at chest height with both hands cupping the top weight. Stand with feet shoulder-width apart. Keep the weight close to your chest with elbows pointing down. Squat down by pushing hips back and bending knees, keeping your chest up. Go as deep as possible while maintaining form. Push through heels to return to start.',
  ),
  'barbell_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position a barbell across your upper back (on your traps, not your neck). Grip the bar slightly wider than shoulder-width. Unrack the bar and step back. Stand with feet shoulder-width apart. Brace your core, keep chest up. Push hips back and bend knees to squat down until thighs are parallel or lower. Drive through your heels to stand back up, keeping the bar path vertical.',
  ),
  'barbell_back_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position a barbell across your upper back (on your traps, not your neck). Grip the bar slightly wider than shoulder-width. Unrack the bar and step back. Stand with feet shoulder-width apart. Brace your core, keep chest up. Push hips back and bend knees to squat down until thighs are parallel or lower. Drive through your heels to stand back up, keeping the bar path vertical.',
  ),
  'back_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position a barbell across your upper back (on your traps, not your neck). Grip the bar slightly wider than shoulder-width. Unrack the bar and step back. Stand with feet shoulder-width apart. Brace your core, keep chest up. Push hips back and bend knees to squat down until thighs are parallel or lower. Drive through your heels to stand back up, keeping the bar path vertical.',
  ),
  'front_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'upper_back': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Rest a barbell across the front of your shoulders with elbows pointed forward and up. Use a clean grip (fingers under bar) or crossed-arm grip. Keep elbows as high as possible throughout. Stand with feet shoulder-width apart. Squat down by pushing hips back and bending knees, keeping your torso as upright as possible. Drive through heels to stand.',
  ),
  'zercher_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'upper_back': 0.6,
      'biceps': 0.6,
    },
    description: 'HOW TO: Hold a barbell in the crook of your elbows (bend of your arms) with arms bent. Stand with feet shoulder-width apart. Keep your chest up and core braced. Squat down by pushing hips back and bending knees while keeping the bar secure in your elbows. Maintain an upright torso. Drive through heels to stand. You may need padding for comfort.',
  ),
  'overhead_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'upper_back': 0.5,
      'triceps': 0.6,
    },
    description: 'HOW TO: Press or snatch a barbell overhead with a wide grip and arms fully locked out. Position the bar directly over your midfoot. Keep arms straight and locked throughout. Squat down by pushing hips back and bending knees while keeping the bar balanced directly overhead. Keep your chest up and core tight. Drive through heels to stand, maintaining the bar position overhead.',
  ),
  'hack_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'hamstrings': 0.6,
      'calves': 0.6,
    },
    description: 'HOW TO: Position yourself in a hack squat machine with your back against the pad and shoulders under the shoulder pads. Place feet on the platform shoulder-width apart. Release the safety handles. Lower down by bending your knees, letting your hips drop straight down. Go as deep as comfortable. Push through your heels to drive back up to the starting position.',
  ),
  'sissy_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart, holding onto a post or rail for balance. Rise up onto the balls of your feet. Lean back while simultaneously pushing your knees forward and lowering your hips. Keep your body in a straight line from knees to shoulders. Lower as far as comfortable. Contract your quads to pull yourself back up to the starting position.',
  ),
  'sumo_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet significantly wider than shoulder-width, toes pointed out at 45 degrees. Keep your chest up and core braced. Squat down by sitting back and spreading your knees outward in line with your toes. Go down until thighs are parallel or lower. Keep your torso upright. Push through your heels to stand, squeezing your glutes and inner thighs.',
  ),
  'sumo_squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet significantly wider than shoulder-width, toes pointed out at 45 degrees. Keep your chest up and core braced. Squat down by sitting back and spreading your knees outward in line with your toes. Go down until thighs are parallel or lower. Keep your torso upright. Push through your heels to stand, squeezing your glutes and inner thighs.',
  ),
  'split_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand in a staggered stance with one foot forward and one foot back (about 2-3 feet apart). Keep your torso upright. Lower straight down by bending both knees until your back knee nearly touches the floor and front thigh is parallel to the ground. Your front knee should stay behind your toes. Push through your front heel to return to start. Complete all reps on one side, then switch.',
  ),
  'split_squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand in a staggered stance with one foot forward and one foot back (about 2-3 feet apart). Keep your torso upright. Lower straight down by bending both knees until your back knee nearly touches the floor and front thigh is parallel to the ground. Your front knee should stay behind your toes. Push through your front heel to return to start. Complete all reps on one side, then switch.',
  ),
  'bulgarian_split_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand 2-3 feet in front of a bench or elevated surface. Place the top of your rear foot on the bench behind you. Keep your torso upright and core engaged. Lower down by bending your front knee and dropping your hips straight down until your front thigh is parallel to the floor. Push through your front heel to return to start. Complete all reps, then switch legs.',
  ),
  'bulgarian_split_squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand 2-3 feet in front of a bench or elevated surface. Place the top of your rear foot on the bench behind you. Keep your torso upright and core engaged. Lower down by bending your front knee and dropping your hips straight down until your front thigh is parallel to the floor. Push through your front heel to return to start. Complete all reps, then switch legs.',
  ),
  'bulgarian_split': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand 2-3 feet in front of a bench or elevated surface. Place the top of your rear foot on the bench behind you. Keep your torso upright and core engaged. Lower down by bending your front knee and dropping your hips straight down until your front thigh is parallel to the floor. Push through your front heel to return to start. Complete all reps, then switch legs.',
  ),
  'bulgarian_split_squat_bw': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand 2-3 feet in front of a bench. Place the top of your rear foot on the bench behind you with no weight. Keep your torso upright and core engaged. Lower down by bending your front knee and dropping your hips straight down until your front thigh is parallel to the floor. Push through your front heel to return to start. Complete all reps, then switch legs.',
  ),
  'lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step forward with one leg, landing heel first. Lower your hips by bending both knees to 90 degrees. Keep your front knee aligned over your ankle, not past your toes. Your back knee should hover just above the floor. Push through your front heel to return to starting position. Alternate legs or complete all reps on one side.',
  ),
  'lunges': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step forward with one leg, landing heel first. Lower your hips by bending both knees to 90 degrees. Keep your front knee aligned over your ankle, not past your toes. Your back knee should hover just above the floor. Push through your front heel to return to starting position. Alternate legs or complete all reps on one side.',
  ),
  'walking_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step forward into a lunge, lowering until both knees are bent at 90 degrees. Instead of pushing back, bring your back leg forward and step directly into the next lunge. Continue walking forward with each lunge, alternating legs. Keep your torso upright and core engaged throughout.',
  ),
  'walking_lunges': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step forward into a lunge, lowering until both knees are bent at 90 degrees. Instead of pushing back, bring your back leg forward and step directly into the next lunge. Continue walking forward with each lunge, alternating legs. Keep your torso upright and core engaged throughout.',
  ),
  'reverse_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step backward with one leg, landing on the ball of your foot. Lower your hips by bending both knees until they form 90-degree angles. Your front knee stays over your ankle. Push through your front heel to return your back leg to the starting position. Alternate legs or complete all reps on one side.',
  ),
  'reverse_lunges': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step backward with one leg, landing on the ball of your foot. Lower your hips by bending both knees until they form 90-degree angles. Your front knee stays over your ankle. Push through your front heel to return your back leg to the starting position. Alternate legs or complete all reps on one side.',
  ),
  'static_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a lunge position with one foot forward and one back, feet hip-width apart. Keep this foot position throughout. Lower your back knee toward the floor by bending both knees to 90 degrees. Push through your front heel to return to the starting lunge position. Do not step your feet together. Complete all reps on one side, then switch.',
  ),
  'deficit_reverse_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand on a raised platform or plates (2-4 inches high) with feet hip-width apart. Step backward with one leg, allowing it to descend below the level of your front foot. Lower until your front thigh is parallel to the floor. The deficit increases range of motion. Push through your front heel to bring your back leg back to the platform.',
  ),
  'curtsy_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'adductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step one leg diagonally behind and across your body, like a curtsy. Lower your hips by bending both knees until your front thigh is parallel to the floor. Keep your torso upright and facing forward. Push through your front heel to return to start. Complete all reps on one side, then switch.',
  ),
  'curtsy_lunges': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'adductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Step one leg diagonally behind and across your body, like a curtsy. Lower your hips by bending both knees until your front thigh is parallel to the floor. Keep your torso upright and facing forward. Push through your front heel to return to start. Complete all reps on one side, then switch.',
  ),
  'pulse_curtsy_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'adductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a curtsy lunge position with one leg crossed behind the other. Instead of returning to standing, perform small pulsing movements (1-2 inches) up and down in the bottom position. Keep constant tension on the muscles. After completing pulses, return to standing. Switch sides.',
  ),
  'lateral_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet together. Take a wide step directly to the side with one leg. As you plant that foot, push your hips back and bend that knee while keeping the other leg straight. Lower until your bent leg is parallel to the floor. Keep your chest up and weight on your heel. Push through your heel to return to start. Alternate sides.',
  ),
  'lateral_lunges': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet together. Take a wide step directly to the side with one leg. As you plant that foot, push your hips back and bend that knee while keeping the other leg straight. Lower until your bent leg is parallel to the floor. Keep your chest up and weight on your heel. Push through your heel to return to start. Alternate sides.',
  ),
  'jump_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a lunge position with one foot forward. Explosively jump straight up, swinging your arms for momentum. While in the air, switch your legs. Land softly with the opposite leg forward, immediately lowering into the next lunge. Keep your torso upright. Continue alternating legs with each jump.',
  ),
  'jump_lunges': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a lunge position with one foot forward. Explosively jump straight up, swinging your arms for momentum. While in the air, switch your legs. Land softly with the opposite leg forward, immediately lowering into the next lunge. Keep your torso upright. Continue alternating legs with each jump.',
  ),
  'jumping_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a lunge position with one foot forward. Explosively jump straight up, swinging your arms for momentum. While in the air, switch your legs. Land softly with the opposite leg forward, immediately lowering into the next lunge. Keep your torso upright. Continue alternating legs with each jump.',
  ),
  'leg_press': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Sit in the leg press machine with your back and head against the padded support. Place feet on the platform about shoulder-width apart. Release the safety handles. Bend your knees to lower the weight, bringing your knees toward your chest. Go as deep as comfortable without letting your lower back round. Push through your heels to extend your legs back to start. Keep a slight bend in knees at the top.',
  ),
  'leg_press_high': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Sit in the leg press machine. Place your feet high on the platform, near the top edge. Position them slightly wider than shoulder-width. Release safety handles. Bend your knees to lower the weight, allowing deeper hip flexion. The high foot placement shifts emphasis to glutes and hamstrings. Push through your heels to return to start.',
  ),
  'jump_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Squat down until thighs are parallel to the floor, keeping your chest up. Explosively jump straight up as high as possible, extending through your hips, knees, and ankles. Swing your arms up for momentum. Land softly with bent knees, immediately lowering into the next squat. Maintain control throughout.',
  ),
  'jump_squats': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Squat down until thighs are parallel to the floor, keeping your chest up. Explosively jump straight up as high as possible, extending through your hips, knees, and ankles. Swing your arms up for momentum. Land softly with bent knees, immediately lowering into the next squat. Maintain control throughout.',
  ),
  'squat_jump': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Squat down until thighs are parallel to the floor, keeping your chest up. Explosively jump straight up as high as possible, extending through your hips, knees, and ankles. Swing your arms up for momentum. Land softly with bent knees, immediately lowering into the next squat. Maintain control throughout.',
  ),
  'squat_jumps': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Squat down until thighs are parallel to the floor, keeping your chest up. Explosively jump straight up as high as possible, extending through your hips, knees, and ankles. Swing your arms up for momentum. Land softly with bent knees, immediately lowering into the next squat. Maintain control throughout.',
  ),
  'squat_reach': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'shoulders': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, arms at your sides. Squat down by pushing hips back and bending knees. As you stand back up, simultaneously reach both arms straight overhead as high as possible. Lower arms as you squat back down. Maintain a smooth, controlled rhythm throughout the movement.',
  ),
  'pistol_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.5,
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Stand on one leg, extending the other leg straight in front of you. Hold your arms straight out for balance. Squat down on your standing leg as deep as possible while keeping the lifted leg extended parallel to the floor. Keep your weight on your heel and chest up. Push through your heel to return to standing. This requires significant strength, balance, and mobility.',
  ),
  'box_jump': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'calves': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a sturdy box or platform (12-30 inches high). Stand an arms length away from the box. Swing your arms back, bend your knees, then explosively jump onto the box, swinging arms forward and up. Land softly on top of the box with both feet, knees slightly bent. Stand up fully on the box. Step down carefully (don\'t jump down).',
  ),
  'box_jumps': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'calves': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a sturdy box or platform (12-30 inches high). Stand an arms length away from the box. Swing your arms back, bend your knees, then explosively jump onto the box, swinging arms forward and up. Land softly on top of the box with both feet, knees slightly bent. Stand up fully on the box. Step down carefully one foot at a time (don\'t jump down to reduce impact).',
  ),
  'jumping_jack': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Start standing with feet together and arms at your sides. In one motion, jump your feet out to the sides (wider than shoulder-width) while simultaneously raising your arms out and overhead until hands nearly touch. Immediately jump back to the starting position with feet together and arms at sides. Keep a steady, continuous rhythm. Land softly on the balls of your feet.',
  ),
  'jumping_jacks': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Start standing with feet together and arms at your sides. In one motion, jump your feet out to the sides (wider than shoulder-width) while simultaneously raising your arms out and overhead until hands nearly touch. Immediately jump back to the starting position with feet together and arms at sides. Keep a steady, continuous rhythm. Land softly on the balls of your feet.',
  ),
  'tuck_jump': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
      'calves': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Bend your knees slightly, then explosively jump straight up as high as possible. While in the air, quickly pull your knees up toward your chest, bringing them as high as you can. Extend your legs back down to land softly with bent knees. Immediately go into the next jump. Keep your core tight throughout.',
  ),
  'tuck_jumps': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
      'calves': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Bend your knees slightly, then explosively jump straight up as high as possible. While in the air, quickly pull your knees up toward your chest, bringing them as high as you can. Extend your legs back down to land softly with bent knees. Immediately go into the next jump. Keep your core tight throughout.',
  ),
  'star_jump': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'shoulders': 0.0,
      'calves': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Start standing with feet together, knees slightly bent. Explosively jump up while simultaneously spreading your arms and legs wide into an X or star shape. Reach your arms overhead and legs out to the sides at the peak of your jump. Bring your limbs back together before landing softly with feet together and arms at sides. Immediately repeat.',
  ),
  'star_jumps': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'shoulders': 0.0,
      'calves': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Start standing with feet together, knees slightly bent. Explosively jump up while simultaneously spreading your arms and legs wide into an X or star shape. Reach your arms overhead and legs out to the sides at the peak of your jump. Bring your limbs back together before landing softly with feet together and arms at sides. Immediately repeat.',
  ),
  'lateral_hop': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'calves': 0.0,
    },
    secondaryMuscles: {
      'adductors': 0.5,
      'hip_abductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand on one leg or both feet. Bend your knees slightly. Explosively hop laterally (sideways) to one side, landing on one or both feet. Immediately hop back to the other side without pausing. Keep your hops quick and controlled, staying on the balls of your feet. Maintain a slight bend in your knees throughout. Focus on landing softly and balanced.',
  ),
  'lateral_hops': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'calves': 0.0,
    },
    secondaryMuscles: {
      'adductors': 0.5,
      'hip_abductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand on one leg or both feet. Bend your knees slightly. Explosively hop laterally (sideways) to one side, landing on one or both feet. Immediately hop back to the other side without pausing. Keep your hops quick and controlled, staying on the balls of your feet. Maintain a slight bend in your knees throughout. Focus on landing softly and balanced.',
  ),
  'skater_hop': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'adductors': 0.5,
      'hip_abductors': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start standing on your right leg with left leg slightly behind. Leap laterally to the left, landing on your left foot while swinging your right leg behind you. As you land, bring your right arm across your body and left arm back (like a speed skater). Immediately push off and leap back to the right side. Continue alternating sides in a smooth, skating motion. Focus on single-leg stability with each landing.',
  ),
  'burpee': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
      'core': 0.5,
      'calves': 0.6,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Start standing. Drop down and place your hands on the floor. Jump or step your feet back into a plank position. Perform a push-up, lowering your chest to the floor. Push back up to plank. Jump or step your feet forward to your hands. Explosively jump up, reaching your arms overhead. Land softly and immediately go into the next rep.',
  ),
  'burpees': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
      'core': 0.5,
      'calves': 0.6,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Start standing. Drop down and place your hands on the floor. Jump or step your feet back into a plank position. Perform a push-up, lowering your chest to the floor. Push back up to plank. Jump or step your feet forward to your hands. Explosively jump up, reaching your arms overhead. Land softly and immediately go into the next rep.',
  ),
  'modified_burpee': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'core': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
      'quads': 0.6,
      'glutes': 0.6,
    },
    description: 'HOW TO: Start standing. Bend down and place hands on floor. Step (don\'t jump) one foot back at a time into a plank position. Perform a push-up on your knees if needed, or skip the push-up entirely. Step feet forward one at a time back to hands. Stand up without jumping. This lower-impact version is perfect for beginners or those with joint concerns.',
  ),
  'burpee_tuck_jump': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'quads': 0.0,
      'glutes': 0.0,
      'core': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
      'hip_flexors': 0.5,
      'calves': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Perform a standard burpee (hands down, jump back to plank, push-up, jump feet forward). Instead of a regular jump at the end, explosively jump up and pull your knees up toward your chest in a tuck position. Extend legs before landing softly. Immediately go into the next burpee. This advanced variation significantly increases intensity.',
  ),
  'burpee_sprawl': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'core': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
      'glutes': 0.6,
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Start standing. Drop down and place hands on floor. Instead of jumping feet straight back, kick them back and wide (sprawl position) with hips close to the ground. Quickly bring feet back to hands. Stand up (no jump). This MMA-style variation emphasizes hip mobility and ground-based conditioning.',
  ),
  'sprawl': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'chest': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Start standing. Quickly drop into a plank position by placing hands on the floor and kicking your feet back and wide (wider than shoulder-width). Keep hips low to the ground. Immediately snap your feet back forward to your hands. Stand up. No push-up or jump. Focus on speed and explosive hip movement. This is a conditioning staple from combat sports.',
  ),
  'sprawls': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'chest': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Start standing. Quickly drop into a plank position by placing hands on the floor and kicking your feet back and wide (wider than shoulder-width). Keep hips low to the ground. Immediately snap your feet back forward to your hands. Stand up. No push-up or jump. Focus on speed and explosive hip movement. This is a conditioning staple from combat sports.',
  ),
  'squat_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Squat down until thighs are parallel to the floor. Hold this bottom position. Perform small pulsing movements (1-2 inches up and down) without standing up. Keep constant tension on your quads and glutes. Continue pulsing for the prescribed reps or time. Maintain proper squat form throughout with chest up and weight on heels.',
  ),
  'sumo_squat_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet wide (wider than shoulder-width) and toes pointed out at 45 degrees. Squat down into the bottom of a sumo squat. Hold this position. Perform small pulsing movements up and down (1-2 inches) without fully standing. Keep your knees pushed outward and torso upright. Feel the burn in your inner thighs and glutes.',
  ),
  'sumo_squat_hold_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet wide (wider than shoulder-width) and toes pointed out at 45 degrees. Squat down into the bottom of a sumo squat. Hold this position. Perform small pulsing movements up and down (1-2 inches) without fully standing. Keep your knees pushed outward and torso upright. Feel the burn in your inner thighs and glutes.',
  ),
  'banded_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'hip_abductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Place a resistance band around your thighs just above your knees. Stand with feet shoulder-width apart. As you squat down, actively push your knees outward against the band resistance. Keep pushing out throughout the entire movement. Squat to parallel or below. Drive through heels to stand, maintaining outward knee pressure. The band activates your glute medius and teaches proper knee tracking.',
  ),
  'banded_lateral_walk': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hip_abductors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Place a resistance band around your thighs (just above knees) or around your ankles. Stand with feet hip-width apart, creating tension on the band. Bend your knees slightly into a quarter squat position. Step sideways with one foot, then bring the other foot to match, maintaining constant tension on the band. Take 10-20 steps in one direction, then reverse. Keep your hips level and core engaged.',
  ),
  'squat_to_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Perform a full squat, lowering until thighs are parallel to the floor. As you stand back up, shift your weight to one leg and kick the other leg straight back behind you, squeezing your glute hard at the top. Return that foot to the ground. Squat again and repeat on the opposite side. Alternate legs with each rep.',
  ),
  'squat_press': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'triceps': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Hold dumbbells at shoulder height or a barbell across your front shoulders. Stand with feet shoulder-width apart. Squat down until thighs are parallel. As you explosively drive up from the squat, use that momentum to press the weight straight overhead until arms are fully extended. Lower the weight back to shoulders as you descend into the next squat. Keep the movement fluid.',
  ),
  'barbell_squat_press': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'triceps': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Hold a barbell across your front shoulders in a front rack position. Stand with feet shoulder-width apart. Squat down until thighs are parallel. As you explosively drive up from the squat, use that momentum to press the barbell straight overhead until arms are fully extended. Lower the bar back to shoulders as you descend into the next squat.',
  ),
  'thruster': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'triceps': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Hold dumbbells at shoulder height or barbell in front rack. Feet shoulder-width apart. Perform a front squat by squatting down until thighs are parallel, keeping your elbows up. Drive explosively through your heels to stand. As you reach full extension, immediately press the weight overhead in one continuous motion. Lower back to shoulders and go straight into next squat. This is one fluid movement.',
  ),
  'thrusters': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'triceps': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Hold dumbbells at shoulder height or barbell in front rack. Feet shoulder-width apart. Perform a front squat by squatting down until thighs are parallel, keeping your elbows up. Drive explosively through your heels to stand. As you reach full extension, immediately press the weight overhead in one continuous motion. Lower back to shoulders and go straight into next squat. This is one fluid movement.',
  ),
  'spanish_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Anchor a resistance band at knee height behind you. Loop the band behind your knees. Step forward to create tension, with the band pulling your knees forward. Stand with feet shoulder-width apart. Squat down by bending your knees while the band restricts forward knee movement. The band forces your quads to work harder. Squat to comfortable depth, then stand. This specialized variation is excellent for quad development and knee health.',
  ),
  // 'clamshell': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'glutes': 0.0,
  //     'hip_abductors': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Lie on your side with hips and knees bent at 90 degrees, feet together. Rest your head on your lower arm. Keep your feet touching throughout. Lift your top knee as high as possible while keeping your feet together, like opening a clamshell. Hold briefly at the top, squeezing your glute. Lower with control. Keep your hips stacked and don\'t roll backward. Complete all reps, then switch sides.',
  // ),
  // 'side_lying_leg_lift': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'hip_abductors': 0.0,
  //     'glutes': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Lie on your side with legs straight and stacked on top of each other. Rest your head on your lower arm. Keep your top leg straight. Lift your top leg up toward the ceiling as high as you can while keeping it straight. Hold briefly at the top. Lower with control without letting your legs touch. Keep your hips stacked and core engaged. Complete all reps, then switch sides.',
  // ),
  // 'fire_hydrant_pulse': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'glutes': 0.0,
  //     'hip_abductors': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keeping your knee bent at 90 degrees, lift one leg out to the side until your thigh is parallel to the floor (like a dog at a fire hydrant). Hold this top position. Perform small pulsing movements up and down (1-2 inches) for the prescribed reps. Lower leg down. Complete all reps, then switch sides.',
  // ),
  'crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor. Place your hands behind your head, elbows out to the sides. Engage your abs and curl your upper back off the floor, lifting your shoulders toward your hips. Only your shoulder blades should lift off the floor. Keep your lower back pressed down. Hold briefly at the top, squeezing your abs. Lower with control.',
  ),
  'crunches': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor. Place your hands behind your head, elbows out to the sides. Engage your abs and curl your upper back off the floor, lifting your shoulders toward your hips. Only your shoulder blades should lift off the floor. Keep your lower back pressed down. Hold briefly at the top, squeezing your abs. Lower with control.',
  ),
  'cable_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Kneel in front of a cable machine with a rope attachment. Grab the rope and hold it at your head/neck level with elbows bent. Keep your hips stationary. Crunch down by flexing your spine and bringing your elbows toward your knees. Contract your abs hard. Pause at the bottom. Return to start with control, keeping tension on your abs. Don\'t let the weight pull you up.',
  ),
  'cable_crunches': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Kneel in front of a cable machine with a rope attachment. Grab the rope and hold it at your head/neck level with elbows bent. Keep your hips stationary. Crunch down by flexing your spine and bringing your elbows toward your knees. Contract your abs hard. Pause at the bottom. Return to start with control, keeping tension on your abs. Don\'t let the weight pull you up.',
  ),
  'sit_up': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on your back with knees bent and feet flat (or anchored). Place hands behind your head or across your chest. Engage your core and curl your entire torso up until you\'re sitting upright. Unlike crunches, your entire back comes off the floor. Keep your feet down. Lower back down with control. You can have someone hold your feet or anchor them under something stable.',
  ),
  'sit_ups': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on your back with knees bent and feet flat (or anchored). Place hands behind your head or across your chest. Engage your core and curl your entire torso up until you\'re sitting upright. Unlike crunches, your entire back comes off the floor. Keep your feet down. Lower back down with control. You can have someone hold your feet or anchor them under something stable.',
  ),
  'situp': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on your back with knees bent and feet flat (or anchored). Place hands behind your head or across your chest. Engage your core and curl your entire torso up until you\'re sitting upright. Unlike crunches, your entire back comes off the floor. Keep your feet down. Lower back down with control. You can have someone hold your feet or anchor them under something stable.',
  ),
  'situps': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on your back with knees bent and feet flat (or anchored). Place hands behind your head or across your chest. Engage your core and curl your entire torso up until you\'re sitting upright. Unlike crunches, your entire back comes off the floor. Keep your feet down. Lower back down with control. You can have someone hold your feet or anchor them under something stable.',
  ),
  'decline_situp': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on a decline bench with your head lower than your feet. Secure your feet under the foot pads at the top of the bench. Place hands behind your head or across chest. Curl your torso up against gravity until you\'re sitting upright. The decline increases resistance. Lower back down with control, using your abs to resist the downward pull.',
  ),
  'decline_weighted_sit_up': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on a decline bench with feet secured at the top. Hold a weight plate on your chest with both hands. Curl your torso up until sitting upright, keeping the plate on your chest. The combination of decline angle and added weight significantly increases difficulty. Lower back down with control. This is advanced core work.',
  ),
  'standing_oblique_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart, hands behind your head with elbows wide. Shift your weight to your left leg. Lift your right knee up and out to the side while simultaneously crunching your right elbow down to meet it. Contract your right obliques. Lower with control and repeat. Complete all reps on one side, then switch. This standing variation targets obliques while improving balance.',
  ),
  // 'bear_crawl': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //     'shoulders': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'quads': 0.5,
  //     'hip_flexors': 0.5,
  //     'triceps': 0.6,
  //   },
  //   description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Lift your knees 1-2 inches off the ground. Crawl forward by moving opposite hand and foot together (right hand with left foot). Keep your hips low, back flat, and core tight. Keep your knees hovering off the ground throughout. Move slowly and controlled, or fast for conditioning. Crawl forward or backward.',
  // ),
  // 'bear_crawls': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //     'shoulders': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'quads': 0.5,
  //     'hip_flexors': 0.5,
  //     'triceps': 0.6,
  //   },
  //   description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Lift your knees 1-2 inches off the ground. Crawl forward by moving opposite hand and foot together (right hand with left foot). Keep your hips low, back flat, and core tight. Keep your knees hovering off the ground throughout. Move slowly and controlled, or fast for conditioning. Crawl forward or backward.',
  // ),
  // 'inchworm': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'hamstrings': 0.0,
  //     'core': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'shoulders': 0.5,
  //     'lower_back': 0.6,
  //     'calves': 0.6,
  //   },
  //   description: 'HOW TO: Stand with feet hip-width apart. Bend forward at the hips and place your hands on the floor in front of your feet (bend knees slightly if needed). Walk your hands forward until you\'re in a plank position, keeping your legs as straight as possible. Hold the plank briefly. Walk your feet toward your hands in small steps, keeping legs straight. Stand up. Repeat.',
  // ),
  'step_up': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a box or bench (12-24 inches high). Place your entire right foot on the box, heel close to the edge. Push through your right heel to step up onto the box, bringing your left foot up to meet it. Stand fully upright on the box. Step back down with your left foot first, then right. That\'s one rep. Complete all reps leading with the right leg, then switch.',
  ),
  'step_ups': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a box or bench (12-24 inches high). Place your entire right foot on the box, heel close to the edge. Push through your right heel to step up onto the box, bringing your left foot up to meet it. Stand fully upright on the box. Step back down with your left foot first, then right. That\'s one rep. Complete all reps leading with the right leg, then switch.',
  ),
  'stepups_chair': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Use a sturdy chair as your platform. Ensure it won\'t slide. Place your entire right foot on the chair seat. Push through your right heel to step up onto the chair, bringing your left foot up. Stand fully upright. Step back down carefully with your left foot first. Complete all reps on one leg, then switch. Hold weights for added difficulty.',
  ),
  'box_stepups': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a box or bench (12-24 inches high). Place your entire right foot on the box, heel close to the edge. Push through your right heel to step up onto the box, bringing your left foot up to meet it. Stand fully upright on the box. Step back down with your left foot first, then right. That\'s one rep. Complete all reps leading with the right leg, then switch.',
  ),
  'box_step_up': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a box or bench (12-24 inches high). Place your entire right foot on the box, heel close to the edge. Push through your right heel to step up onto the box, bringing your left foot up to meet it. Stand fully upright on the box. Step back down with your left foot first, then right. That\'s one rep. Complete all reps leading with the right leg, then switch.',
  ),
  'pushup': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands directly under your shoulders, slightly wider than shoulder-width. Keep your body in a straight line from head to heels, core tight. Lower your body by bending your elbows at about 45 degrees from your body until your chest nearly touches the floor. Keep elbows from flaring out too wide. Push through your palms to straighten your arms back to starting position.',
  ),
  'pushups': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands directly under your shoulders, slightly wider than shoulder-width. Keep your body in a straight line from head to heels, core tight. Lower your body by bending your elbows at about 45 degrees from your body until your chest nearly touches the floor. Keep elbows from flaring out too wide. Push through your palms to straighten your arms back to starting position.',
  ),
  'push_up': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands directly under your shoulders, slightly wider than shoulder-width. Keep your body in a straight line from head to heels, core tight. Lower your body by bending your elbows at about 45 degrees from your body until your chest nearly touches the floor. Keep elbows from flaring out too wide. Push through your palms to straighten your arms back to starting position.',
  ),
  'push_ups': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands directly under your shoulders, slightly wider than shoulder-width. Keep your body in a straight line from head to heels, core tight. Lower your body by bending your elbows at about 45 degrees from your body until your chest nearly touches the floor. Keep elbows from flaring out too wide. Push through your palms to straighten your arms back to starting position.',
  ),
  'incline_push_up': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Place your hands on an elevated surface like a bench, box, or countertop at chest height. Walk your feet back until your body is in a straight line at an incline angle. Keep your core engaged. Lower your chest toward the surface by bending your elbows. Push back up to starting position. The higher the surface, the easier the movement. Perfect for beginners building toward regular push-ups.',
  ),
  'incline_push_ups': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Place your hands on an elevated surface like a bench, box, or countertop at chest height. Walk your feet back until your body is in a straight line at an incline angle. Keep your core engaged. Lower your chest toward the surface by bending your elbows. Push back up to starting position. The higher the surface, the easier the movement. Perfect for beginners building toward regular push-ups.',
  ),
  'wall_push_up': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a wall, about arm\'s length away. Place your hands flat on the wall at shoulder height and slightly wider than shoulder-width. Keep your body straight. Lean toward the wall by bending your elbows, bringing your chest close to the wall. Push back to starting position. This is the easiest push-up variation, ideal for absolute beginners or those recovering from injury.',
  ),
  'decline_push_up': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Place your feet on an elevated surface (bench or box 12-24 inches high) and hands on the floor shoulder-width apart. Your body should be in a downward angle. Keep your body in a straight line. Lower your chest toward the floor by bending your elbows. The decline angle increases resistance and shifts emphasis to upper chest and shoulders. Push back up to starting position.',
  ),
  'wide_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position but place your hands significantly wider than shoulder-width (6-12 inches beyond shoulders on each side). Keep your body straight. Lower down by bending your elbows, letting them flare out wider. Go down until chest nearly touches the floor. The wider hand placement increases chest stretch and reduces triceps involvement. Push back up.',
  ),
  'wide_pushups': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position but place your hands significantly wider than shoulder-width (6-12 inches beyond shoulders on each side). Keep your body straight. Lower down by bending your elbows, letting them flare out wider. Go down until chest nearly touches the floor. The wider hand placement increases chest stretch and reduces triceps involvement. Push back up.',
  ),
  'diamond_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position. Place your hands together directly under your chest so your thumbs and index fingers touch, forming a diamond or triangle shape. Keep your body straight, core tight. Lower your body by bending your elbows, keeping them close to your sides. Go down until your chest nearly touches your hands. Push back up. This narrow hand position intensely targets triceps.',
  ),
  'diamond_pushups': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position. Place your hands together directly under your chest so your thumbs and index fingers touch, forming a diamond or triangle shape. Keep your body straight, core tight. Lower your body by bending your elbows, keeping them close to your sides. Go down until your chest nearly touches your hands. Push back up. This narrow hand position intensely targets triceps.',
  ),
  'diamond_push_up': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position. Place your hands together directly under your chest so your thumbs and index fingers touch, forming a diamond or triangle shape. Keep your body straight, core tight. Lower your body by bending your elbows, keeping them close to your sides. Go down until your chest nearly touches your hands. Push back up. This narrow hand position intensely targets triceps.',
  ),
  'close_grip_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands closer than shoulder-width (hands about 6-8 inches apart). Keep your elbows tucked close to your sides throughout the movement. Lower your body by bending elbows, keeping them tight to your ribs. Go down until chest nearly touches the floor. Push back up. The close grip emphasizes triceps and inner chest.',
  ),
  'close_grip_push_ups': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands closer than shoulder-width (hands about 6-8 inches apart). Keep your elbows tucked close to your sides throughout the movement. Lower your body by bending elbows, keeping them tight to your ribs. Go down until chest nearly touches the floor. Push back up. The close grip emphasizes triceps and inner chest.',
  ),
  'close_grip_push_up': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands closer than shoulder-width (hands about 6-8 inches apart). Keep your elbows tucked close to your sides throughout the movement. Lower your body by bending elbows, keeping them tight to your ribs. Go down until chest nearly touches the floor. Push back up. The close grip emphasizes triceps and inner chest.',
  ),
  'close_grip_pushups': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a plank position with hands closer than shoulder-width (hands about 6-8 inches apart). Keep your elbows tucked close to your sides throughout the movement. Lower your body by bending elbows, keeping them tight to your ribs. Go down until chest nearly touches the floor. Push back up. The close grip emphasizes triceps and inner chest.',
  ),
  'decline_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Place your feet on an elevated surface (bench or box 12-24 inches high) and hands on the floor shoulder-width apart. Your body should be in a downward angle. Keep your body in a straight line. Lower your chest toward the floor by bending your elbows. The decline angle increases resistance and shifts emphasis to upper chest and shoulders. Push back up to starting position.',
  ),
  'decline_pushups': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Place your feet on an elevated surface (bench or box 12-24 inches high) and hands on the floor shoulder-width apart. Your body should be in a downward angle. Keep your body in a straight line. Lower your chest toward the floor by bending your elbows. The decline angle increases resistance and shifts emphasis to upper chest and shoulders. Push back up to starting position.',
  ),
  'incline_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Place your hands on an elevated surface like a bench, box, or countertop at chest height. Walk your feet back until your body is in a straight line at an incline angle. Keep your core engaged. Lower your chest toward the surface by bending your elbows. Push back up to starting position. The higher the surface, the easier the movement.',
  ),
  'incline_pushups': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Place your hands on an elevated surface like a bench, box, or countertop at chest height. Walk your feet back until your body is in a straight line at an incline angle. Keep your core engaged. Lower your chest toward the surface by bending your elbows. Push back up to starting position. The higher the surface, the easier the movement.',
  ),
  'pike_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a downward dog yoga position with hips raised high, forming an inverted V with your body. Keep your legs as straight as possible and hands shoulder-width apart. Bend your elbows to lower the top of your head toward the floor between your hands. Keep your hips elevated throughout. Push back up to starting position. This mimics an overhead press movement using bodyweight.',
  ),
  'pike_pushups': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a downward dog yoga position with hips raised high, forming an inverted V with your body. Keep your legs as straight as possible and hands shoulder-width apart. Bend your elbows to lower the top of your head toward the floor between your hands. Keep your hips elevated throughout. Push back up to starting position. This mimics an overhead press movement using bodyweight.',
  ),
  'pike_push_ups': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a downward dog yoga position with hips raised high, forming an inverted V with your body. Keep your legs as straight as possible and hands shoulder-width apart. Bend your elbows to lower the top of your head toward the floor between your hands. Keep your hips elevated throughout. Push back up to starting position. This mimics an overhead press movement using bodyweight.',
  ),
  'archer_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a wide push-up position with hands placed much wider than shoulder-width. As you lower down, shift your weight to one side while straightening the opposite arm out to the side (like drawing a bow). The working arm bends while the other stays straight for minimal support. Push back up through the working side. Alternate sides or complete all reps on one side.',
  ),
  'archer_push_up': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a wide push-up position with hands placed much wider than shoulder-width. As you lower down, shift your weight to one side while straightening the opposite arm out to the side (like drawing a bow). The working arm bends while the other stays straight for minimal support. Push back up through the working side. Alternate sides or complete all reps on one side.',
  ),
  'clap_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Start in a standard push-up position. Lower down into a push-up. Explosively push up with maximum force so your hands leave the floor. While airborne, quickly clap your hands together. Land with hands back in push-up position with elbows slightly bent to absorb impact. Immediately lower into the next rep. This plyometric variation builds explosive upper body power.',
  ),
  'plank_to_pushup': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'triceps': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
    },
    description: 'HOW TO: Start in a forearm plank position with elbows under shoulders. Place your right hand flat on the floor where your right elbow was, then your left hand where your left elbow was, pushing up into a high plank position. Lower back down onto your right forearm, then left forearm. Continue alternating which arm leads. Keep your hips as stable as possible throughout, avoiding rocking side to side.',
  ),
  'bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench with feet flat on the floor. Grip the barbell slightly wider than shoulder-width. Unrack the bar and hold it above your chest with arms extended. Lower the bar with control to your mid-chest, keeping elbows at about 45-degree angle from your body. Touch your chest lightly. Press the bar back up in a slight arc until arms are fully extended. Keep shoulder blades retracted throughout.',
  ),
  'barbell_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench with feet flat on the floor. Grip the barbell slightly wider than shoulder-width. Unrack the bar and hold it above your chest with arms extended. Lower the bar with control to your mid-chest, keeping elbows at about 45-degree angle from your body. Touch your chest lightly. Press the bar back up in a slight arc until arms are fully extended. Keep shoulder blades retracted throughout.',
  ),
  'dumbbell_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench holding a dumbbell in each hand. Start with dumbbells at chest level, elbows bent at 90 degrees and palms facing forward. Press the dumbbells straight up until arms are fully extended, bringing them slightly together at the top. Lower with control back to chest level. Dumbbells allow a greater range of motion than barbells and help address strength imbalances.',
  ),
  'incline_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
    },
    description: 'HOW TO: Set a bench to 30-45 degree incline. Lie back with feet flat on the floor. Grip the barbell slightly wider than shoulder-width. Unrack and hold above your upper chest. Lower the bar to your upper chest/collarbone area. Keep elbows at 45-degree angle from body. Press back up until arms are extended. The incline targets upper chest and front shoulders more than flat bench.',
  ),
  'incline_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
    },
    description: 'HOW TO: Set a bench to 30-45 degree incline. Lie back with feet flat on the floor. Grip the barbell slightly wider than shoulder-width. Unrack and hold above your upper chest. Lower the bar to your upper chest/collarbone area. Keep elbows at 45-degree angle from body. Press back up until arms are extended. The incline targets upper chest and front shoulders more than flat bench.',
  ),
  'incline_db_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
    },
    description: 'HOW TO: Set bench to 30-45 degree incline. Sit back holding dumbbells at shoulder height with palms facing forward. Press the dumbbells straight up until arms are extended, bringing them slightly together at the top. Lower with control back to shoulder height. The incline with dumbbells allows greater range of motion and independent arm movement for upper chest development.',
  ),
  'incline_dumbbell_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
    },
    description: 'HOW TO: Set bench to 30-45 degree incline. Sit back holding dumbbells at shoulder height with palms facing forward. Press the dumbbells straight up until arms are extended, bringing them slightly together at the top. Lower with control back to shoulder height. The incline with dumbbells allows greater range of motion and independent arm movement for upper chest development.',
  ),
  'incline_barbell_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
    },
    description: 'HOW TO: Set bench to 30-45 degree incline. Lie back, grip barbell slightly wider than shoulder-width. Unrack and hold above upper chest. Lower bar to upper chest/collarbone with control. Press back up until arms fully extended. The barbell allows you to load heavier than dumbbells for maximum upper chest strength development.',
  ),
  'decline_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set bench to 15-30 degree decline. Lie back and secure your feet under the foot pads at the top of the bench. Grip barbell slightly wider than shoulder-width. Unrack and hold above your lower chest. Lower the bar to your lower chest/sternum. Press back up until arms are extended. The decline angle targets the lower portion of the chest while reducing shoulder involvement.',
  ),
  'decline_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set bench to 15-30 degree decline. Lie back and secure your feet under the foot pads at the top of the bench. Grip barbell slightly wider than shoulder-width. Unrack and hold above your lower chest. Lower the bar to your lower chest/sternum. Press back up until arms are extended. The decline angle targets the lower portion of the chest while reducing shoulder involvement.',
  ),
  'decline_dumbbell_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set bench to decline. Secure your feet at the top. Hold dumbbells at chest level with palms facing forward. Press the dumbbells up until arms are extended, bringing them slightly together at the top. Lower with control. Dumbbells provide greater range of motion and muscle activation than barbells on the decline.',
  ),
  'decline_barbell_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set bench to 15-30 degree decline. Secure feet under pads. Grip barbell slightly wider than shoulder-width. Unrack and hold above lower chest. Lower bar to lower chest/sternum area. Press back up until arms fully extended. Use a spotter for safety on decline barbell work.',
  ),
  'dumbbell_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench holding a dumbbell in each hand. Start with dumbbells at chest level, elbows bent at 90 degrees and palms facing forward. Press the dumbbells straight up until arms are fully extended, bringing them slightly together at the top. Lower with control back to chest level. Can be performed flat, incline, or decline.',
  ),
  'close_grip_bench': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench. Grip the barbell with hands about shoulder-width apart or slightly closer (not too narrow to avoid wrist strain). Unrack and hold above your chest. Lower the bar to your lower chest/sternum, keeping elbows tucked close to your sides. Press back up until arms are fully extended. This variation emphasizes triceps over chest.',
  ),
  'close_grip_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench. Grip the barbell with hands about shoulder-width apart or slightly closer (not too narrow to avoid wrist strain). Unrack and hold above your chest. Lower the bar to your lower chest/sternum, keeping elbows tucked close to your sides. Press back up until arms are fully extended. This variation emphasizes triceps over chest.',
  ),
  'jm_press': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a bench with close grip on barbell. Unrack and hold above chest. Lower the bar by bending only at the elbows (don\'t let upper arms move), bringing bar toward your neck/upper chest. Keep upper arms nearly perpendicular to your body. Your forearms should move while upper arms stay still. Press back up by extending elbows. This hybrid between skull crusher and close-grip bench isolates triceps.',
  ),
  'machine_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Sit in the chest press machine and adjust the seat so handles are at mid-chest height. Grip the handles with palms facing down or forward. Keep your back against the pad. Push the handles forward until your arms are fully extended. Pause briefly. Return with control to the starting position. The machine provides a fixed movement path for safe, focused chest work.',
  ),
  'landmine_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Place one end of a barbell in a landmine attachment or corner. Stand facing away from the anchor point. Hold the top end of the bar at shoulder height with one or both hands. Press the bar up and forward at an angle until arms are extended. Lower back to shoulder height with control. The angled press path targets upper chest and front shoulders while challenging core stability.',
  ),
  'overhead_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold a barbell at shoulder height with hands just outside shoulders, palms facing forward. Brace your core and squeeze your glutes. Press the bar straight overhead until arms are fully extended, moving your head slightly back to let the bar pass. Lock out at the top. Lower with control back to shoulders. Keep your core tight throughout to protect your lower back.',
  ),
  'shoulder_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Can be performed seated or standing with dumbbells or barbell. Start with weight at shoulder height, hands just outside shoulders. Press the weight straight overhead until arms are fully extended. Lower with control back to shoulder height. Seated removes leg drive and isolates shoulders more. Standing engages more core and allows heavier loads.',
  ),
  'military_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand at attention with feet together (heels touching). Hold barbell at shoulder height with hands just outside shoulders. Keep your body rigid with no leg drive. Press the bar straight overhead until arms are fully extended. Lower back to shoulders with control. The strict stance and no-leg-drive requirement makes this harder than a standard overhead press and isolates the shoulders more.',
  ),
  'arnold_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Sit or stand holding dumbbells at shoulder height with palms facing you (toward your face). As you press the dumbbells up, rotate your palms to face forward. At the top, palms should face away from you with arms fully extended. Lower while rotating palms back to face you. The rotation engages all three heads of the deltoid through a greater range of motion than standard presses.',
  ),
  'push_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'quads': 0.5,
      'glutes': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, holding a barbell at shoulder height in front rack position. Dip down by bending your knees 2-4 inches, keeping your torso upright. Explosively drive through your legs to generate momentum. As your legs extend, use that momentum to press the bar overhead until arms are fully locked out. Lower the bar back to shoulders with control. The leg drive allows heavier weight than strict pressing.',
  ),
  'seated_db_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support set to 90 degrees. Hold dumbbells at shoulder height with palms facing forward, elbows bent at 90 degrees. Press the dumbbells straight up overhead until arms are fully extended. Bring them slightly together at the top. Lower with control back to shoulder height. The seated position eliminates leg drive and isolates the shoulders.',
  ),
  'seated_dumbbell_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support set to 90 degrees. Hold dumbbells at shoulder height with palms facing forward, elbows bent at 90 degrees. Press the dumbbells straight up overhead until arms are fully extended. Bring them slightly together at the top. Lower with control back to shoulder height. The seated position eliminates leg drive and isolates the shoulders.',
  ),
  'standing_dumbbell_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'core': 0.5,
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold dumbbells at shoulder height with palms facing forward. Brace your core and squeeze glutes for stability. Press the dumbbells straight overhead until arms are fully extended. Lower with control back to shoulders. Standing requires more core stability than seated and allows you to generate slight momentum from your body.',
  ),
  'seated_shoulder_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support. Hold a barbell or dumbbells at shoulder height. Press the weight straight overhead until arms are fully extended. Lower back to shoulder height with control. Can be performed with barbell or dumbbells. The seated position provides back support and strict shoulder isolation.',
  ),
  'dumbbell_shoulder_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Can be performed seated or standing. Hold dumbbells at shoulder height with palms facing forward. Press them overhead until arms are fully extended. Lower with control back to shoulders. Dumbbells allow independent arm movement and a more natural pressing path compared to barbells.',
  ),
  'barbell_overhead_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold barbell at shoulder height with hands just wider than shoulders. Brace core, squeeze glutes. Press the bar straight up, moving your head back slightly to let the bar pass close to your face. Lock out arms overhead. Lower with control back to shoulders. The barbell allows maximum loading for shoulder strength.',
  ),
  'machine_shoulder_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Sit in the shoulder press machine and adjust the seat so handles are at shoulder height. Grip the handles with palms facing forward or neutral. Press the handles straight up until arms are fully extended. Lower with control back to starting position. The machine provides a fixed, safe movement path ideal for training to failure.',
  ),
  'db_overhead_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Hold dumbbells at shoulder height with palms forward. Can be seated or standing. Press dumbbells straight overhead until arms are fully extended, bringing them slightly together at the top. Lower with control back to shoulders. Dumbbells provide natural movement and help address imbalances.',
  ),
  'standing_ohp': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, barbell at shoulder height. Brace core tight, squeeze glutes. Press bar straight overhead moving head back slightly. Lock out arms at top. Lower with control to shoulders. Standing position engages your entire body and allows natural body positioning for maximum strength.',
  ),
  'ohp': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Overhead Press. Stand with barbell at shoulder height, hands just outside shoulders. Brace core and glutes. Press bar straight overhead until arms fully extended. Lower with control back to shoulders. This fundamental compound movement builds powerful shoulders and total upper body strength.',
  ),
  'dip': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Grip parallel bars and jump or step up to support yourself with arms straight (starting position). Keep your body upright for triceps emphasis, or lean forward 15-30 degrees for chest emphasis. Lower by bending elbows until upper arms are parallel to the floor or slightly below. Push back up to starting position by straightening arms. Body angle determines muscle emphasis.',
  ),
  'dips': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Grip parallel bars and jump or step up to support yourself with arms straight (starting position). Keep your body upright for triceps emphasis, or lean forward 15-30 degrees for chest emphasis. Lower by bending elbows until upper arms are parallel to the floor or slightly below. Push back up to starting position by straightening arms. Body angle determines muscle emphasis.',
  ),
  'tricep_dip': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Grip parallel bars and support yourself with arms straight. Keep your torso as upright as possible and elbows tucked close to your body. Lower by bending elbows, keeping them pointing straight back (not flaring out). Go down until upper arms are parallel to the floor. Press back up by straightening arms. The upright position maximizes triceps engagement.',
  ),
  'tricep_dips': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Grip parallel bars and support yourself with arms straight. Keep your torso as upright as possible and elbows tucked close to your body. Lower by bending elbows, keeping them pointing straight back (not flaring out). Go down until upper arms are parallel to the floor. Press back up by straightening arms. The upright position maximizes triceps engagement.',
  ),
  'bench_dip': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Sit on the edge of a bench and place your hands next to your hips, fingers pointing forward. Extend your legs out in front (straight for harder, bent for easier). Slide your butt off the bench, supporting yourself with your arms. Lower by bending elbows until upper arms are parallel to floor. Push back up by straightening arms. Keep elbows pointing back, not flaring out.',
  ),
  'bench_dips': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Sit on the edge of a bench and place your hands next to your hips, fingers pointing forward. Extend your legs out in front (straight for harder, bent for easier). Slide your butt off the bench, supporting yourself with your arms. Lower by bending elbows until upper arms are parallel to floor. Push back up by straightening arms. Keep elbows pointing back, not flaring out.',
  ),
  'dip_machine': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
    },
    description: 'HOW TO: Adjust the weight stack to provide assistance. Grip the handles and place your knees or feet on the assist platform. The machine will push you up, reducing the bodyweight you need to lift. Lower yourself until upper arms are parallel to floor. Push back up. Adjust weight to control difficulty - more weight = easier dips.',
  ),
  'weighted_dip': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Wear a dip belt with weight plates attached, or hold a dumbbell between your feet. Grip parallel bars and support yourself with arms straight. Lower by bending elbows until upper arms are parallel to floor. Push back up to starting position. Adding weight increases difficulty and builds serious upper body strength and mass.',
  ),
  'ring_dip': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
    },
    description: 'HOW TO: Grip gymnastics rings and jump up to support position with arms straight. The rings will be unstable. Keep your body as stable as possible and core tight. Lower by bending elbows until upper arms are parallel to floor or below. Press back up. Fight to keep the rings from moving apart. The instability requires significantly more shoulder stabilization.',
  ),
  'ring_dips': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
    },
    description: 'HOW TO: Grip gymnastics rings and jump up to support position with arms straight. The rings will be unstable. Keep your body as stable as possible and core tight. Lower by bending elbows until upper arms are parallel to floor or below. Press back up. Fight to keep the rings from moving apart. The instability requires significantly more shoulder stabilization.',
  ),
  'chest_dips': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Grip parallel bars and support yourself with arms straight. Lean your torso forward 30-45 degrees and flare your elbows out slightly. Lower by bending elbows until you feel a deep stretch in your chest. Push back up to starting position. The forward lean and elbow flare shifts emphasis from triceps to chest, especially lower chest.',
  ),
  'dips_chest': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Grip parallel bars and support yourself with arms straight. Lean your torso forward 30-45 degrees and flare your elbows out slightly. Lower by bending elbows until you feel a deep stretch in your chest. Push back up to starting position. The forward lean and elbow flare shifts emphasis from triceps to chest, especially lower chest.',
  ),
  'tricep_dips_chair': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Place hands on the edge of a sturdy chair, fingers pointing forward. Extend legs out in front. Slide butt off the chair, supporting yourself with arms. Lower by bending elbows until upper arms are parallel to floor. Push back up by straightening arms. Ensure the chair is stable and won\'t slide. Keep elbows pointing back.',
  ),
  'chest_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells directly above your chest with arms extended, palms facing each other. Keep a slight bend in your elbows (like hugging a barrel). Lower the weights out to the sides in a wide arc, keeping the elbow angle constant. Go down until you feel a stretch in your chest. Bring the weights back together above your chest using the same arc. Do NOT press - maintain the arc motion throughout.',
  ),
  'chest_flys': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells directly above your chest with arms extended, palms facing each other. Keep a slight bend in your elbows (like hugging a barrel). Lower the weights out to the sides in a wide arc, keeping the elbow angle constant. Go down until you feel a stretch in your chest. Bring the weights back together above your chest using the same arc. Do NOT press - maintain the arc motion throughout.',
  ),
  'chest_flyes': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells directly above your chest with arms extended, palms facing each other. Keep a slight bend in your elbows (like hugging a barrel). Lower the weights out to the sides in a wide arc, keeping the elbow angle constant. Go down until you feel a stretch in your chest. Bring the weights back together above your chest using the same arc. Do NOT press - maintain the arc motion throughout.',
  ),
  'cable_chest_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Stand centered between two cable machines set at shoulder height. Grab a handle in each hand and step forward to create tension. Lean slightly forward with one foot ahead. With a slight bend in elbows, bring your hands together in front of your chest in a hugging motion, keeping the elbow angle constant. Squeeze your chest at the peak. Return to start with control, letting your arms open wide.',
  ),
  'dumbbell_chest_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells directly above your chest with arms extended, palms facing each other. Keep a slight bend in your elbows. Lower the weights out to the sides in a wide arc. Go down until you feel a deep stretch in your chest. Bring the weights back together above your chest using the same arc motion. This isolates the chest without triceps involvement.',
  ),
  'dumbbell_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells directly above your chest with arms extended, palms facing each other. Keep a slight bend in your elbows. Lower the weights out to the sides in a wide arc. Go down until you feel a deep stretch in your chest. Bring the weights back together above your chest using the same arc motion. This isolates the chest without triceps involvement.',
  ),
  'dumbbell_flys': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells directly above your chest with arms extended, palms facing each other. Keep a slight bend in your elbows. Lower the weights out to the sides in a wide arc. Go down until you feel a deep stretch in your chest. Bring the weights back together above your chest using the same arc motion. This isolates the chest without triceps involvement.',
  ),
  'dumbbell_flyes': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells directly above your chest with arms extended, palms facing each other. Keep a slight bend in your elbows. Lower the weights out to the sides in a wide arc. Go down until you feel a deep stretch in your chest. Bring the weights back together above your chest using the same arc motion. This isolates the chest without triceps involvement.',
  ),
  'cable_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Stand centered between two cable machines set at shoulder height. Grab a handle in each hand and step forward. Lean slightly forward. With slight elbow bend, bring hands together in front of chest in a hugging motion. Squeeze chest hard. Return with control, letting arms open wide. Cables provide constant tension throughout the movement.',
  ),
  'cable_flys': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Stand centered between two cable machines set at shoulder height. Grab a handle in each hand and step forward. Lean slightly forward. With slight elbow bend, bring hands together in front of chest in a hugging motion. Squeeze chest hard. Return with control, letting arms open wide. Cables provide constant tension throughout the movement.',
  ),
  'cable_flyes': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Stand centered between two cable machines set at shoulder height. Grab a handle in each hand and step forward. Lean slightly forward. With slight elbow bend, bring hands together in front of chest in a hugging motion. Squeeze chest hard. Return with control, letting arms open wide. Cables provide constant tension throughout the movement.',
  ),
  'cable_flye': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Stand centered between two cable machines set at shoulder height. Grab a handle in each hand and step forward. Lean slightly forward. With slight elbow bend, bring hands together in front of chest in a hugging motion. Squeeze chest hard. Return with control, letting arms open wide. Cables provide constant tension throughout the movement.',
  ),
  'cable_crossover': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand centered between high cable pulleys. Grab a handle in each hand and step forward. Start with arms out wide at shoulder height or higher. Bring the handles down and together across your body in a crossing motion, with one hand crossing in front of the other. Squeeze your chest hard. Return to start with control. Alternate which hand crosses on top.',
  ),
  'pec_deck': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Sit in the pec deck machine with back flat against the pad. Place your forearms on the pads with elbows bent at 90 degrees. Grab the handles. Press the pads together by squeezing your chest, bringing your elbows together in front of you. Squeeze hard at the peak. Slowly return to starting position, feeling the stretch in your chest.',
  ),
  'machine_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Sit in a chest fly machine with back against the pad. Adjust seat height so handles are at chest level. Grab handles with a slight bend in elbows. Bring the handles together in front of you by squeezing your chest. Hold the contraction briefly. Return to start with control. The machine provides a stable path for pure chest isolation.',
  ),
  'machine_chest_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Sit in a chest fly machine with back against the pad. Adjust seat height so handles are at chest level. Grab handles with a slight bend in elbows. Bring the handles together in front of you by squeezing your chest. Hold the contraction briefly. Return to start with control. The machine provides a stable path for pure chest isolation.',
  ),
  'incline_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set bench to 30-45 degree incline. Lie back holding dumbbells above your upper chest with arms extended, palms facing each other. Keep a slight bend in elbows. Lower weights out to sides in an arc until you feel a stretch in upper chest. Bring weights back together using the same arc. The incline targets the upper chest fibers.',
  ),
  'incline_flys': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set bench to 30-45 degree incline. Lie back holding dumbbells above your upper chest with arms extended, palms facing each other. Keep a slight bend in elbows. Lower weights out to sides in an arc until you feel a stretch in upper chest. Bring weights back together using the same arc. The incline targets the upper chest fibers.',
  ),
  'lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing in. Keep a slight bend in your elbows. Raise the weights out to your sides (laterally) until arms are parallel to the floor, leading with your elbows. Your hands should be slightly lower than your elbows at the top. Pause briefly. Lower with control. Avoid shrugging or using momentum. This isolates the side deltoids.',
  ),
  'lateral_raises': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing in. Keep a slight bend in your elbows. Raise the weights out to your sides (laterally) until arms are parallel to the floor, leading with your elbows. Your hands should be slightly lower than your elbows at the top. Pause briefly. Lower with control. Avoid shrugging or using momentum. This isolates the side deltoids.',
  ),
  'dumbbell_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing in. Keep a slight bend in your elbows. Raise the weights out to your sides (laterally) until arms are parallel to the floor, leading with your elbows. Your hands should be slightly lower than your elbows at the top. Pause briefly. Lower with control. Avoid shrugging or using momentum. This isolates the side deltoids.',
  ),
  'leaning_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Hold onto a stable post or rack with one hand. Lean away from it to create an angle. Hold a dumbbell in your free hand at your side. Perform a lateral raise with the free arm, raising the weight out to the side until arm is parallel to floor. The lean increases the range of motion and time under tension. Lower with control. Complete reps, then switch sides.',
  ),
  'front_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs with palms facing your body. Keep a slight bend in your elbows and core tight. Raise the weights straight forward and up until arms are parallel to the floor (or slightly above). Pause briefly. Lower with control back to thighs. Don\'t swing or use momentum. This isolates the front deltoids.',
  ),
  'front_raises': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs with palms facing your body. Keep a slight bend in your elbows and core tight. Raise the weights straight forward and up until arms are parallel to the floor (or slightly above). Pause briefly. Lower with control back to thighs. Don\'t swing or use momentum. This isolates the front deltoids.',
  ),
  'plate_front_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Stand holding a weight plate with both hands at the 3 and 9 o\'clock positions (sides of the plate). Hold the plate in front of your thighs with arms extended. Raise the plate straight forward and up until arms are parallel to the floor or slightly above. Pause. Lower with control. The plate allows heavier loading than dumbbells.',
  ),
  'dumbbell_front_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'upper_chest': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs with palms facing your body. Keep a slight bend in your elbows and core tight. Raise the weights straight forward and up until arms are parallel to the floor (or slightly above). Pause briefly. Lower with control back to thighs. Don\'t swing or use momentum. This isolates the front deltoids.',
  ),
  'barbell_front_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'upper_chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell in front of your thighs with an overhand grip, hands shoulder-width apart. Keep arms extended with a slight bend in elbows. Raise the barbell straight forward and up until it reaches shoulder height or slightly above. Pause briefly. Lower with control back to thighs. Keep core tight and avoid using momentum or swinging. The barbell allows heavier loading than dumbbells.',
  ),
  'cable_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
    },
    description: 'HOW TO: Stand sideways to a cable machine set at the lowest position. Grab the handle with the hand furthest from the machine (cable will cross your body). Stand upright. Raise your arm out to the side (away from the machine) until it reaches shoulder height, leading with your elbow. Pause. Lower with control. Cables provide constant tension throughout. Complete all reps, then switch sides.',
  ),
  'cable_lateral_raises': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
    },
    description: 'HOW TO: Stand sideways to a cable machine set at the lowest position. Grab the handle with the hand furthest from the machine (cable will cross your body). Stand upright. Raise your arm out to the side (away from the machine) until it reaches shoulder height, leading with your elbow. Pause. Lower with control. Cables provide constant tension throughout. Complete all reps, then switch sides.',
  ),
  // 'plank_shoulder_tap': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //     'shoulders': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'chest': 0.6,
  //     'triceps': 0.6,
  //   },
  //   description: 'HOW TO: Start in a high plank position with hands under shoulders, body in a straight line. Widen your feet slightly for stability. Lift your right hand and tap your left shoulder. Place it back down. Lift your left hand and tap your right shoulder. Continue alternating. Keep your hips as stable as possible - don\'t let them rotate or sag. This anti-rotation exercise builds core stability.',
  // ),
  // 'plank_shoulder_taps': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //     'shoulders': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'chest': 0.6,
  //     'triceps': 0.6,
  //   },
  //   description: 'HOW TO: Start in a high plank position with hands under shoulders, body in a straight line. Widen your feet slightly for stability. Lift your right hand and tap your left shoulder. Place it back down. Lift your left hand and tap your right shoulder. Continue alternating. Keep your hips as stable as possible - don\'t let them rotate or sag. This anti-rotation exercise builds core stability.',
  // ),
  // 'ab_wheel': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'lats': 0.5,
  //     'shoulders': 0.5,
  //     'lower_back': 0.6,
  //   },
  //   description: 'HOW TO: Kneel on the floor holding an ab wheel with both hands. Position the wheel directly under your shoulders. Slowly roll the wheel forward, extending your arms and lowering your body toward the floor. Keep your core tight and back straight - don\'t let your hips sag. Roll out as far as you can while maintaining form. Pull the wheel back to the starting position using your abs and lats.',
  // ),
  // 'ab_wheel_rollout': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'lats': 0.5,
  //     'shoulders': 0.5,
  //     'lower_back': 0.6,
  //   },
  //   description: 'HOW TO: Kneel on the floor holding an ab wheel with both hands. Position the wheel directly under your shoulders. Slowly roll the wheel forward, extending your arms and lowering your body toward the floor. Keep your core tight and back straight - don\'t let your hips sag. Roll out as far as you can while maintaining form. Pull the wheel back to the starting position using your abs and lats.',
  // ),
  // 'ab_wheel_kneeling': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'lats': 0.5,
  //     'shoulders': 0.5,
  //     'lower_back': 0.6,
  //   },
  //   description: 'HOW TO: Kneel on a mat or pad with the ab wheel in front of you. Grip the handles with both hands. Brace your core and keep your back straight. Roll the wheel forward slowly, extending your body. Go as far forward as you can while maintaining a straight spine. Your arms should end up extended in front of you. Pull yourself back to kneeling using your core. Kneeling is easier than standing.',
  // ),
  // 'ab_wheel_standing': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'lats': 0.5,
  //     'shoulders': 0.5,
  //     'hamstrings': 0.5,
  //     'lower_back': 0.6,
  //   },
  //   description: 'HOW TO: Stand with feet together, holding the ab wheel on the floor in front of you. Keeping your legs straight (or slightly bent), roll the wheel forward as you bend at the hips and lower your torso. Roll out until your body is nearly parallel to the floor. Keep core extremely tight. Pull yourself back to standing. This is an extremely advanced variation requiring exceptional core strength.',
  // ),
  'pullup': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip (palms facing away), hands slightly wider than shoulder-width. Start from a dead hang with arms fully extended. Pull yourself up by driving your elbows down and back, bringing your chin above the bar. Keep your chest up and squeeze your shoulder blades together at the top. Lower yourself with control back to a dead hang.',
  ),
  'pullups': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip (palms facing away), hands slightly wider than shoulder-width. Start from a dead hang with arms fully extended. Pull yourself up by driving your elbows down and back, bringing your chin above the bar. Keep your chest up and squeeze your shoulder blades together at the top. Lower yourself with control back to a dead hang.',
  ),
  'pull_up': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip (palms facing away), hands slightly wider than shoulder-width. Start from a dead hang with arms fully extended. Pull yourself up by driving your elbows down and back, bringing your chin above the bar. Keep your chest up and squeeze your shoulder blades together at the top. Lower yourself with control back to a dead hang.',
  ),
  'pull_ups': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip (palms facing away), hands slightly wider than shoulder-width. Start from a dead hang with arms fully extended. Pull yourself up by driving your elbows down and back, bringing your chin above the bar. Keep your chest up and squeeze your shoulder blades together at the top. Lower yourself with control back to a dead hang.',
  ),
  'assisted_pull_up': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Use an assisted pull-up machine or place a resistance band around the bar and put your knee or foot in it. Grip the bar with an overhand grip. The assistance reduces the bodyweight you need to lift. Pull yourself up until chin is above the bar. Lower with control. Gradually reduce assistance as you get stronger. Can also have a partner push your feet up.',
  ),
  'weighted_pull_up': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Attach weight to a dip belt around your waist or hold a dumbbell between your feet. Hang from the bar with an overhand grip. Pull yourself up until chin clears the bar, keeping the added weight controlled. Lower with control back to dead hang. Adding weight increases difficulty and accelerates back and arm development.',
  ),
  'chinup': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an underhand grip (palms facing you), hands about shoulder-width apart. Start from a dead hang. Pull yourself up by bending your elbows and driving them down, bringing your chin above the bar. The underhand grip allows greater biceps involvement than overhand pull-ups. Lower with control back to dead hang.',
  ),
  'chinups': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an underhand grip (palms facing you), hands about shoulder-width apart. Start from a dead hang. Pull yourself up by bending your elbows and driving them down, bringing your chin above the bar. The underhand grip allows greater biceps involvement than overhand pull-ups. Lower with control back to dead hang.',
  ),
  'chin_up': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an underhand grip (palms facing you), hands about shoulder-width apart. Start from a dead hang. Pull yourself up by bending your elbows and driving them down, bringing your chin above the bar. The underhand grip allows greater biceps involvement than overhand pull-ups. Lower with control back to dead hang.',
  ),
  'chin_ups': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an underhand grip (palms facing you), hands about shoulder-width apart. Start from a dead hang. Pull yourself up by bending your elbows and driving them down, bringing your chin above the bar. The underhand grip allows greater biceps involvement than overhand pull-ups. Lower with control back to dead hang.',
  ),
  'wide_grip_pullup': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'biceps': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip, hands placed significantly wider than shoulder-width (6-12 inches beyond shoulders on each side). Start from a dead hang. Pull yourself up, focusing on bringing your elbows down and back. The wide grip increases lat stretch and reduces biceps involvement. Pull until your upper chest approaches the bar. Lower with control.',
  ),
  'close_grip_pullup': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip, hands placed close together (6-8 inches apart or less). Start from a dead hang. Pull yourself up until chin clears the bar. The close grip increases biceps engagement and emphasizes lat thickness. Lower with control back to dead hang.',
  ),
  'neutral_grip_pullup': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Use parallel pull-up handles or a neutral grip attachment with palms facing each other. Hang with arms fully extended. Pull yourself up until chin clears the handles. The neutral grip is often more comfortable on wrists and shoulders than overhand or underhand grips while still effectively targeting the lats. Lower with control.',
  ),
  'muscle_up': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'biceps': 0.5,
      'core': 0.5,
    },
    description: 'HOW TO: Hang from a pull-up bar with a false grip (thumbs over bar) or regular overhand grip. Pull explosively upward, bringing your chest to the bar. As you reach the bar, aggressively transition by rolling your chest forward and up over the bar while driving your elbows back. Press down on the bar to finish in a dip support position with arms straight. Lower back down with control.',
  ),
  'lat_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a lat pulldown machine. Adjust the thigh pad so your legs are secured. Reach up and grab the bar with an overhand grip, hands wider than shoulder-width. Keep your torso upright with a slight lean back. Pull the bar down to your upper chest by driving your elbows down and back. Squeeze your shoulder blades together. Return with control to the top.',
  ),
  'lat_pulldowns': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a lat pulldown machine. Adjust the thigh pad so your legs are secured. Reach up and grab the bar with an overhand grip, hands wider than shoulder-width. Keep your torso upright with a slight lean back. Pull the bar down to your upper chest by driving your elbows down and back. Squeeze your shoulder blades together. Return with control to the top.',
  ),
  'neutral_grip_lat_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Attach a neutral grip handle (palms facing each other) to the lat pulldown cable. Sit and secure your legs under the thigh pad. Grab the handles with a neutral grip. Pull the handles down to your upper chest while keeping your torso upright. Drive elbows down and back. Squeeze your lats at the bottom. Return with control.',
  ),
  'cable_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a cable pulldown station with legs secured. Grab the bar or handle attachment with your desired grip. Pull the bar down to your chest by driving elbows down and back. Keep your torso relatively upright. Squeeze your back muscles at the bottom. Return with control, letting your lats stretch at the top.',
  ),
  'straight_arm_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'triceps': 0.6,
    },
    description: 'HOW TO: Stand facing a cable machine with a straight bar attachment set at head height. Grab the bar with an overhand grip, hands shoulder-width apart. Step back slightly and hinge forward slightly at the hips. With straight arms (slight elbow bend), pull the bar down in an arc to your thighs by engaging your lats. Keep your arms straight throughout - don\'t bend elbows. Return to start with control.',
  ),
  'row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Rowing movements involve pulling weight toward your torso. Can be performed bent over, seated, or on machines. The key is to pull with your back muscles by driving your elbows back and squeezing your shoulder blades together, rather than pulling with your arms. Keep your core tight and back straight throughout.',
  ),
  'rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Rowing movements involve pulling weight toward your torso. Can be performed bent over, seated, or on machines. The key is to pull with your back muscles by driving your elbows back and squeezing your shoulder blades together, rather than pulling with your arms. Keep your core tight and back straight throughout.',
  ),
  'bent_over_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell or dumbbells. Hinge forward at the hips until your torso is about 45 degrees to the floor, keeping your back straight and knees slightly bent. Let the weight hang at arm\'s length. Pull the weight to your lower chest/upper abs by driving your elbows back and up. Squeeze your shoulder blades together. Lower with control.',
  ),
  'bent_over_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell or dumbbells. Hinge forward at the hips until your torso is about 45 degrees to the floor, keeping your back straight and knees slightly bent. Let the weight hang at arm\'s length. Pull the weight to your lower chest/upper abs by driving your elbows back and up. Squeeze your shoulder blades together. Lower with control.',
  ),
  'bent_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell or dumbbells. Hinge forward at the hips until your torso is about 45 degrees to the floor, keeping your back straight and knees slightly bent. Let the weight hang at arm\'s length. Pull the weight to your lower chest/upper abs by driving your elbows back and up. Squeeze your shoulder blades together. Lower with control.',
  ),
  'barbell_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart, holding a barbell with an overhand grip slightly wider than shoulder-width. Hinge at the hips to about 45 degrees, keeping your back straight and core tight. Let the bar hang at arm\'s length. Pull the bar to your lower chest, driving elbows back and up. Squeeze shoulder blades. Lower with control. Keep torso angle constant throughout.',
  ),
  'barbell_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart, holding a barbell with an overhand grip slightly wider than shoulder-width. Hinge at the hips to about 45 degrees, keeping your back straight and core tight. Let the bar hang at arm\'s length. Pull the bar to your lower chest, driving elbows back and up. Squeeze shoulder blades. Lower with control. Keep torso angle constant throughout.',
  ),
  'barbell_bent_over_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart, holding a barbell with an overhand grip. Hinge forward at hips to 45-degree angle, back straight, knees slightly bent. Let bar hang at arm\'s length. Pull the bar to your lower chest/upper abs by driving elbows back. Squeeze shoulder blades together at the top. Lower with control. Maintain torso position throughout.',
  ),
  'dumbbell_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Can be performed bent over with both dumbbells, or single arm. If single arm: Place one hand and same-side knee on a bench for support. Hold a dumbbell in your free hand, letting it hang at arm\'s length. Pull the dumbbell to your hip by driving your elbow back and up. Keep your elbow close to your body. Squeeze your back. Lower with control.',
  ),
  'dumbbell_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Can be performed bent over with both dumbbells, or single arm. If single arm: Place one hand and same-side knee on a bench for support. Hold a dumbbell in your free hand, letting it hang at arm\'s length. Pull the dumbbell to your hip by driving your elbow back and up. Keep your elbow close to your body. Squeeze your back. Lower with control.',
  ),
  'single_arm_db_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Place your left hand and left knee on a bench for support. Your right foot stays on the floor. Hold a dumbbell in your right hand, letting it hang at arm\'s length under your shoulder. Pull the dumbbell straight up to your hip by driving your elbow back. Keep elbow close to your side. Squeeze your back at the top. Lower with control. Complete all reps, then switch sides.',
  ),
  'one_arm_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Place your left hand and left knee on a bench for support. Hold a dumbbell in your right hand, letting it hang at arm\'s length. Pull the dumbbell to your hip by driving your elbow back and up. Keep elbow close to your body. Squeeze your back. Lower with control. The single-arm variation allows greater range of motion and helps address imbalances.',
  ),
  'cable_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Attach a handle to a cable machine set at mid-height. Stand or sit facing the machine. Grab the handle and step or sit back to create tension. Pull the handle to your torso by driving your elbows back. Keep your torso upright or slightly leaned back. Squeeze your back muscles. Return with control. Cables provide constant tension.',
  ),
  'cable_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Attach a handle to a cable machine set at mid-height. Stand or sit facing the machine. Grab the handle and step or sit back to create tension. Pull the handle to your torso by driving your elbows back. Keep your torso upright or slightly leaned back. Squeeze your back muscles. Return with control. Cables provide constant tension.',
  ),
  'seated_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a seated row machine with feet on the platform and knees slightly bent. Grab the handles with arms extended. Sit upright with your chest up. Pull the handles to your lower chest/upper abs by driving your elbows straight back. Squeeze your shoulder blades together. Keep your torso upright throughout. Return with control, letting your shoulders stretch forward.',
  ),
  'seated_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a seated row machine with feet on the platform and knees slightly bent. Grab the handles with arms extended. Sit upright with your chest up. Pull the handles to your lower chest/upper abs by driving your elbows straight back. Squeeze your shoulder blades together. Keep your torso upright throughout. Return with control, letting your shoulders stretch forward.',
  ),
  'seated_cable_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a cable row station with feet on the platform, knees slightly bent. Grab the handle with arms fully extended. Sit upright with chest up and core braced. Pull the handle to your lower chest/upper abs, driving elbows straight back. Squeeze shoulder blades together. Keep torso upright. Return with control.',
  ),
  'seated_cable_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a cable row station with feet on the platform, knees slightly bent. Grab the handle with arms fully extended. Sit upright with chest up and core braced. Pull the handle to your lower chest/upper abs, driving elbows straight back. Squeeze shoulder blades together. Keep torso upright. Return with control.',
  ),
  'machine_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit in a rowing machine with chest against the pad. Adjust seat height so handles are at chest level. Grab the handles with arms extended. Pull the handles back by driving your elbows straight back. Squeeze your shoulder blades together. The chest pad supports your torso, allowing you to focus purely on back contraction. Return with control.',
  ),
  'chest_supported_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Lie chest-down on an incline bench set to 30-45 degrees. Hold dumbbells or grab machine handles, letting your arms hang straight down. Pull the weight up toward your chest by driving your elbows back and up. Squeeze your shoulder blades together. Lower with control. The chest support eliminates lower back stress and prevents cheating through momentum.',
  ),
  'tbar_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Position yourself over a T-bar row setup with the barbell anchored at one end. Straddle the bar and grab the handles (or use a V-grip attachment). Hinge forward at the hips with a straight back. Pull the bar up toward your chest by driving your elbows back. Keep elbows close to your body. Squeeze your back. Lower with control.',
  ),
  'tbar_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Position yourself over a T-bar row setup with the barbell anchored at one end. Straddle the bar and grab the handles (or use a V-grip attachment). Hinge forward at the hips with a straight back. Pull the bar up toward your chest by driving your elbows back. Keep elbows close to your body. Squeeze your back. Lower with control.',
  ),
  't_bar_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Straddle a T-bar with one end anchored on the floor. Hinge forward at the hips with a straight back. Grab the handles or use a V-grip attachment. Let the bar hang at arm\'s length. Pull the bar up toward your chest by driving your elbows back and up. Keep elbows close to your body. Squeeze your back muscles hard. Lower with control. The narrow grip emphasizes mid-back thickness.',
  ),
  'pendlay_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width, barbell on the floor in front of you. Hinge forward until torso is parallel to the floor. Grip the bar slightly wider than shoulder-width. From a dead stop on the floor, explosively pull the bar to your lower chest. Squeeze your back. Lower the bar all the way back to the floor and let it come to a complete stop before the next rep. Reset and repeat.',
  ),
  'pendlay_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_back': 0.5,
      'hamstrings': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width, barbell on the floor in front of you. Hinge forward until torso is parallel to the floor. Grip the bar slightly wider than shoulder-width. From a dead stop on the floor, explosively pull the bar to your lower chest. Squeeze your back. Lower the bar all the way back to the floor and let it come to a complete stop before the next rep. Reset and repeat.',
  ),
  'inverted_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'core': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Set a bar in a rack at waist height (or use a smith machine or TRX straps). Lie under the bar facing up. Grab the bar with an overhand grip, hands shoulder-width apart. Hang with arms extended and body in a straight line from head to heels (like an upside-down plank). Pull your chest to the bar by driving elbows back. Keep body straight. Lower with control.',
  ),
  'inverted_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'core': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Set a bar in a rack at waist height. Lie under the bar facing up. Grab the bar with an overhand grip, hands shoulder-width apart. Hang with arms extended and body in a straight line from head to heels. Pull your chest to the bar by driving elbows back. Keep body straight throughout - don\'t let hips sag. Lower with control.',
  ),
  'renegade_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
      'core': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'shoulders': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Place two dumbbells on the floor shoulder-width apart. Get into a plank position gripping the dumbbell handles. Widen your feet for stability. Row one dumbbell up to your hip by driving your elbow back, while keeping the other arm stable. Fight to keep your hips from rotating - stay square to the floor. Lower the dumbbell. Alternate arms.',
  ),
  'renegade_rows': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
      'core': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'shoulders': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Place two dumbbells on the floor shoulder-width apart. Get into a plank position gripping the dumbbell handles. Widen your feet for stability. Row one dumbbell up to your hip by driving your elbow back, while keeping the other arm stable. Fight to keep your hips from rotating - stay square to the floor. Lower the dumbbell. Alternate arms.',
  ),
  'upright_row': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
      'traps': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell or dumbbells in front of your thighs with an overhand grip, hands about shoulder-width apart (or slightly closer). Keep the weight close to your body. Pull it straight up along your torso toward your chin, leading with your elbows. Your elbows should go higher than your hands. Raise until the bar reaches chest/chin level. Lower with control.',
  ),
  'upright_rows': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
      'traps': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell or dumbbells in front of your thighs with an overhand grip, hands about shoulder-width apart. Keep the weight close to your body. Pull it straight up along your torso toward your chin, leading with your elbows. Your elbows should go higher than your hands. Raise until the bar reaches chest/chin level. Lower with control.',
  ),
  'face_pull': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
      'biceps': 0.6,
    },
    description: 'HOW TO: Attach a rope to a cable machine at upper chest/face height. Grab both ends of the rope with palms facing each other. Step back to create tension. Pull the rope toward your face while separating the rope ends, driving your hands to either side of your head. Pull your elbows back and high. Squeeze your rear delts and upper back. Return with control.',
  ),
  'face_pulls': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'traps': 0.6,
      'biceps': 0.6,
    },
    description: 'HOW TO: Attach a rope to a cable machine at upper chest/face height. Grab both ends of the rope with palms facing each other. Step back to create tension. Pull the rope toward your face while separating the rope ends, driving your hands to either side of your head. Pull your elbows back and high. Squeeze your rear delts and upper back. Return with control.',
  ),
  'reverse_fly': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'traps': 0.6,
    },
    description: 'HOW TO: Sit on the edge of a bench or stand and hinge forward at the hips until torso is nearly parallel to floor. Hold dumbbells under your chest with a slight bend in elbows, palms facing each other. Raise the dumbbells out to your sides in a wide arc, like a reverse hug, until arms are parallel to the floor. Lead with your elbows. Squeeze your rear delts. Lower with control.',
  ),
  'reverse_flys': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'traps': 0.6,
    },
    description: 'HOW TO: Sit on the edge of a bench or stand and hinge forward at the hips until torso is nearly parallel to floor. Hold dumbbells under your chest with a slight bend in elbows, palms facing each other. Raise the dumbbells out to your sides in a wide arc until arms are parallel to the floor. Lead with your elbows. Squeeze your rear delts. Lower with control.',
  ),
  'reverse_flyes': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'traps': 0.6,
    },
    description: 'HOW TO: Sit on the edge of a bench or stand and hinge forward at the hips until torso is nearly parallel to floor. Hold dumbbells under your chest with a slight bend in elbows, palms facing each other. Raise the dumbbells out to your sides in a wide arc until arms are parallel to the floor. Lead with your elbows. Squeeze your rear delts. Lower with control.',
  ),
  'rear_delt_fly': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'traps': 0.6,
    },
    description: 'HOW TO: Sit on the edge of a bench bent forward or stand hinged at hips. Hold dumbbells with palms facing each other, slight elbow bend. Raise dumbbells out to sides in an arc until arms are parallel to floor. Focus on squeezing your rear delts at the top. Lower with control. Keep the motion smooth and controlled without swinging.',
  ),
  'reverse_pec_deck': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'traps': 0.6,
    },
    description: 'HOW TO: Sit facing the pec deck machine backward (chest against the back pad). Adjust seat so handles are at shoulder height. Grab the handles with arms extended. Pull the handles apart by driving your elbows back, squeezing your rear delts and shoulder blades together. Keep a slight bend in elbows. Return with control. The machine provides a stable path for rear delt isolation.',
  ),
  'rear_delt_flys': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'traps': 0.6,
    },
    description: 'HOW TO: Bent forward at hips or seated, hold dumbbells with slight elbow bend and palms facing each other. Raise the dumbbells out to the sides in a wide arc until arms are parallel to the floor. Lead with your elbows and focus on your rear delts. Squeeze at the top. Lower with control.',
  ),
  'shrug': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides or a barbell in front of your thighs. Keep your arms straight. Shrug your shoulders straight up toward your ears as high as possible. Imagine trying to touch your ears with your shoulders. Hold the contraction briefly. Lower with control. Don\'t roll your shoulders - move straight up and down.',
  ),
  'shrugs': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides or a barbell in front of your thighs. Keep your arms straight. Shrug your shoulders straight up toward your ears as high as possible. Imagine trying to touch your ears with your shoulders. Hold the contraction briefly. Lower with control. Don\'t roll your shoulders - move straight up and down.',
  ),
  'barbell_shrugs': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell in front of your thighs with an overhand grip, hands about shoulder-width apart. Keep arms straight and core engaged. Shrug your shoulders straight up as high as possible. Hold the contraction at the top. Lower with control. The barbell allows maximum loading for trap development.',
  ),
  'dumbbell_shrugs': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a dumbbell in each hand at your sides with palms facing your body. Keep arms straight. Shrug your shoulders straight up toward your ears as high as possible. Hold at the top, squeezing your traps. Lower with control. Dumbbells provide a natural movement path and greater range of motion than a barbell.',
  ),
  'deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'upper_back': 0.5,
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand with feet hip-width apart, barbell over mid-foot. Hinge at hips and grip the bar just outside your legs. Lower hips until shins touch the bar. Keep back straight, chest up, shoulders over bar. Brace core. Drive through your heels, extending hips and knees simultaneously to stand up. Keep the bar close to your body. Lock out at top by squeezing glutes. Lower with control by pushing hips back first.',
  ),
  'deadlifts': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'upper_back': 0.5,
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand with feet hip-width apart, barbell over mid-foot. Hinge at hips and grip the bar just outside your legs. Lower hips until shins touch the bar. Keep back straight, chest up, shoulders over bar. Brace core. Drive through your heels, extending hips and knees simultaneously to stand up. Keep the bar close to your body. Lock out at top by squeezing glutes. Lower with control by pushing hips back first.',
  ),
  'rack_pull': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Set a barbell on rack pins or safety bars at knee height (or higher). Stand close to the bar with feet hip-width. Grip the bar just outside your legs. Hinge slightly with a straight back. Drive through your heels to pull the bar up by extending your hips and standing upright. Squeeze glutes and pull shoulders back at the top. Lower with control. This partial deadlift allows heavier loads.',
  ),
  'conventional_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'upper_back': 0.5,
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand with feet hip-width, barbell over mid-foot. Hinge and grip bar just outside your legs with hands shoulder-width. Lower hips, chest up, back straight. Drive through heels, extending hips and knees to stand. Keep bar close. Lock out at top. The conventional stance (narrow) emphasizes the posterior chain.',
  ),
  'deficit_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand on a platform or weight plates 1-4 inches high with a barbell on the floor. The elevated position increases your range of motion. Set up like a conventional deadlift but lower your hips more to reach the bar. Pull the bar off the floor by driving through heels. The deficit strengthens the bottom position and requires more quad involvement.',
  ),
  'sumo_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'quads': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'upper_back': 0.5,
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand with feet very wide (1.5-2x shoulder-width), toes pointed out 30-45 degrees. Barbell over mid-foot. Hinge down and grip the bar between your legs, hands shoulder-width. Keep chest up, back straight. Push knees out. Drive through your heels, focusing on pushing the floor apart. Stand up by extending hips. The wide stance shifts emphasis to glutes, quads, and inner thighs.',
  ),
  'sumo_deadlifts': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'quads': 0.0,
      'adductors': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'upper_back': 0.5,
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand with feet very wide (1.5-2x shoulder-width), toes pointed out 30-45 degrees. Barbell over mid-foot. Hinge down and grip the bar between your legs, hands shoulder-width. Keep chest up, back straight. Push knees out. Drive through your heels, focusing on pushing the floor apart. Stand up by extending hips. The wide stance shifts emphasis to glutes, quads, and inner thighs.',
  ),
  'romanian_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Start standing holding a barbell at hip height with an overhand grip. Stand with feet hip-width. Keep knees slightly bent (don\'t lock them out). Push your hips back while keeping your back straight, lowering the bar down the front of your thighs. Go down until you feel a strong stretch in your hamstrings. Drive your hips forward to return to standing. The bar should stay close to your legs throughout.',
  ),
  'romanian_deadlifts': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Start standing holding a barbell at hip height with an overhand grip. Stand with feet hip-width. Keep knees slightly bent (don\'t lock them out). Push your hips back while keeping your back straight, lowering the bar down the front of your thighs. Go down until you feel a strong stretch in your hamstrings. Drive your hips forward to return to standing. The bar should stay close to your legs throughout.',
  ),
  'rdl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Romanian Deadlift. Start standing with barbell at hip height, overhand grip. Feet hip-width, knees slightly bent. Push hips back, keeping back straight, lowering the bar down your thighs. Go until you feel a deep hamstring stretch. Don\'t round your back. Drive hips forward to stand. Bar stays close to legs throughout.',
  ),
  'dumbbell_rdl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides or in front of your thighs. Feet hip-width apart, knees slightly bent. Push your hips back while keeping your back straight, lowering the dumbbells down the front or sides of your legs. Go until you feel a strong hamstring stretch. Drive hips forward to return to standing. Dumbbells allow a more natural movement path.',
  ),
  'stiff_leg_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell at hip height. Keep your legs completely straight (or just a micro-bend in knees). Push your hips back and lower the bar down the front of your legs by hinging at the hips only. Keep your back straight. Go as low as your hamstring flexibility allows. Drive hips forward to stand. This variation provides maximum hamstring stretch.',
  ),
  'stiff_leg_deadlifts': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell at hip height. Keep your legs completely straight (or just a micro-bend in knees). Push your hips back and lower the bar down the front of your legs by hinging at the hips only. Keep your back straight. Go as low as your hamstring flexibility allows. Drive hips forward to stand. This variation provides maximum hamstring stretch.',
  ),
  'single_leg_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Stand on your right leg, holding a dumbbell in your left hand (or vice versa). Keep a slight bend in your standing knee. Hinge at the hip, lowering the dumbbell toward the floor while extending your left leg straight behind you for balance. Keep your back straight. Lower until your torso is parallel to the floor. Drive through your standing heel to return to upright. Complete all reps, then switch legs.',
  ),
  'single_leg_deadlifts': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Stand on your right leg, holding a dumbbell in your left hand. Keep a slight bend in your standing knee. Hinge at the hip, lowering the dumbbell toward the floor while extending your left leg straight behind you for balance. Keep your back straight. Lower until your torso is parallel to the floor. Drive through your standing heel to return to upright. Complete all reps, then switch legs.',
  ),
  'single_leg_rdl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Stand on one leg holding a dumbbell or kettlebell. Keep a slight bend in your standing knee. Push your hips back and lower the weight toward the floor while extending your free leg behind you. Keep your back straight and core tight. Go until you feel a hamstring stretch. Drive your hips forward to return to standing. Complete all reps, then switch.',
  ),
  'trap_bar_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'upper_back': 0.5,
      'core': 0.5,
      'forearms': 0.5,
    },
    description: 'HOW TO: Step inside a trap bar (hex bar) so it\'s around you. Grip the handles at your sides with a neutral grip. Lower your hips, keeping chest up and back straight. Drive through your heels to stand up straight. The neutral grip and weight distribution allows a more upright torso position, reducing lower back stress and increasing quad involvement compared to barbell deadlifts.',
  ),
  'good_morning': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
    },
    description: 'HOW TO: Place a barbell across your upper back (on traps, not neck). Stand with feet shoulder-width apart. Keeping your legs nearly straight (slight knee bend), hinge forward at the hips while maintaining a straight back. Lower your torso until it\'s nearly parallel to the floor. You should feel a stretch in your hamstrings. Drive your hips forward to return to standing. Keep the bar stable on your back throughout.',
  ),
  'good_mornings': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
    },
    description: 'HOW TO: Place a barbell across your upper back (on traps, not neck). Stand with feet shoulder-width apart. Keeping your legs nearly straight (slight knee bend), hinge forward at the hips while maintaining a straight back. Lower your torso until it\'s nearly parallel to the floor. You should feel a stretch in your hamstrings. Drive your hips forward to return to standing. Keep the bar stable on your back throughout.',
  ),
  'kettlebell_swing': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'shoulders': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, kettlebell on the floor in front of you. Hinge at the hips and grip the kettlebell with both hands. Hike the kettlebell back between your legs. Explosively drive your hips forward (hip thrust) to swing the kettlebell up to shoulder height. Let momentum carry it up - don\'t lift with your arms. Let it swing back down between your legs and immediately repeat. The power comes from hip drive, not arms.',
  ),
  'kettlebell_swings': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'shoulders': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, kettlebell on the floor in front of you. Hinge at the hips and grip the kettlebell with both hands. Hike the kettlebell back between your legs. Explosively drive your hips forward to swing the kettlebell up to shoulder height. Let momentum carry it up - don\'t lift with arms. Let it swing back and immediately repeat. Power comes from hip drive.',
  ),
  'kb_swing': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'shoulders': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, kettlebell in front. Hinge and grip with both hands. Hike it back between your legs. Explosively drive hips forward to swing the kettlebell up to shoulder height. Let momentum carry it - arms stay relaxed. Swing back down and repeat. Focus on powerful hip extension.',
  ),
  'russian_swing': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'shoulders': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Perform a kettlebell swing but only swing the kettlebell to chest/shoulder height (not overhead). Hinge at hips, swing the kettlebell back between legs, then explosively drive hips forward. Stop the swing at shoulder height with arms parallel to the floor. This traditional variation emphasizes pure hip power without overhead mechanics.',
  ),
  'american_swing': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'lower_back': 0.0,
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Perform a kettlebell swing but swing the kettlebell all the way overhead until your arms are fully extended and locked out. Drive explosively from your hips. As the bell reaches shoulder height, guide it overhead. Lock out arms at the top. Let it swing back down and repeat. This variation requires more shoulder mobility and engagement at the top position.',
  ),
  'hip_thrust': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on the floor with your upper back against a bench. Place a barbell (with padding) across your hips. Plant your feet flat on the floor, hip-width apart, knees bent. Drive through your heels to thrust your hips up, lifting the barbell until your body forms a straight line from shoulders to knees. Squeeze your glutes hard at the top. Lower with control. This is the king of glute exercises.',
  ),
  'hip_thrusts': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on the floor with your upper back against a bench. Place a barbell (with padding) across your hips. Plant your feet flat on the floor, hip-width apart, knees bent. Drive through your heels to thrust your hips up, lifting the barbell until your body forms a straight line from shoulders to knees. Squeeze your glutes hard at the top. Lower with control. This is the king of glute exercises.',
  ),
  'glute_bridge': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor, hip-width apart. Place feet close enough that you can almost touch your heels with your fingertips. Keep arms at your sides. Drive through your heels to lift your hips off the floor, squeezing your glutes hard. Raise until your body forms a straight line from shoulders to knees. Hold briefly. Lower with control.',
  ),
  'glute_bridges': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor, hip-width apart. Place feet close enough that you can almost touch your heels with your fingertips. Keep arms at your sides. Drive through your heels to lift your hips off the floor, squeezing your glutes hard. Raise until your body forms a straight line from shoulders to knees. Hold briefly. Lower with control.',
  ),
  'single_leg_glute_bridge': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Lie on your back with one knee bent and foot flat on the floor. Extend the other leg straight out in front of you. Keep arms at your sides. Drive through your planted heel to lift your hips off the floor until your body forms a straight line. Squeeze your working glute hard at the top. Keep your extended leg straight and aligned with your body. Lower with control. Complete all reps, then switch legs.',
  ),
  'elevated_glute_bridge': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on your back with your feet elevated on a bench or box, knees bent. Place arms at your sides. Drive through your heels to lift your hips off the floor until your body forms a straight line from shoulders to knees. Squeeze your glutes hard at the top. The elevated position increases range of motion and glute activation. Lower with control.',
  ),
  'banded_glute_bridge': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'hip_abductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Place a resistance band around your thighs just above your knees. Lie on your back with knees bent and feet flat, hip-width apart. As you drive your hips up into a bridge, actively push your knees outward against the band. Hold the top position while maintaining outward knee pressure. This activates the glute medius. Lower with control.',
  ),
  'barbell_hip_thrust': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on the floor with your upper back resting against a bench. Roll a barbell (with padding) over your legs and position it across your hips. Plant feet flat on the floor, hip-width apart. Drive through your heels to thrust your hips up, lifting the barbell until your body forms a straight line from shoulders to knees. Squeeze glutes maximally at top. Lower with control.',
  ),
  'glute_bridge_single': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Lie on your back with one foot flat on the floor, knee bent. Extend the other leg straight up or straight out in front of you. Drive through your planted heel to lift your hips off the floor. Squeeze your working glute hard at the top. Keep your extended leg aligned with your body. Lower with control. Complete all reps, then switch legs.',
  ),
  'glute_bridge_hold': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor. Drive through your heels to thrust your hips up into a bridge position. Hold this top position for the prescribed time (typically 20-60 seconds). Keep your glutes squeezed maximally throughout the hold. Maintain a straight line from shoulders to knees. This isometric hold builds glute endurance.',
  ),
  'frog_pump': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and the soles of your feet pressed together (frog position), letting your knees fall out to the sides. Keep your feet close to your glutes. Drive your hips up by squeezing your glutes, lifting your hips off the floor. Lower and repeat in a pumping motion. This unique foot position isolates the glutes by removing hamstring involvement.',
  ),
  'frog_pumps': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and the soles of your feet pressed together (frog position), letting your knees fall out to the sides. Keep your feet close to your glutes. Drive your hips up by squeezing your glutes, lifting your hips off the floor. Lower and repeat in a pumping motion. This unique foot position isolates the glutes by removing hamstring involvement.',
  ),
  'frog_pump_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Get into frog pump position (on your back, soles of feet together, knees out). Thrust your hips up to the top position. Instead of lowering all the way down, perform small pulsing movements (1-2 inches up and down) at the top. Keep constant tension on your glutes. The pulses create an intense burn.',
  ),
  'frog_pump_hold_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Get into frog pump position and thrust hips to the top. Hold this position while performing small pulsing movements. Keep your glutes maximally contracted throughout. This combination of isometric hold plus pulses creates extreme glute fatigue and activation.',
  ),
  'quadruped_hip_extension': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'lower_back': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep your core tight and back flat. Extend one leg straight back and up behind you, keeping it straight. Lift until your leg is in line with your body or slightly higher. Squeeze your glute hard at the top. Lower with control without touching the floor. Complete all reps, then switch legs.',
  ),
  'quadruped_hip_extension_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'lower_back': 0.6,
    },
    description: 'HOW TO: Start on all fours. Extend one leg straight back and up to the top position. Hold your leg at the top. Perform small pulsing movements up and down (1-2 inches) while keeping your leg extended. Keep your glute contracted throughout. After completing pulses, lower the leg. Switch sides.',
  ),
  'standing_glute_squeeze': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand with feet hip-width apart, hands on hips or at sides. Contract your glutes as hard as you possibly can, squeezing them together. Hold this maximum contraction for the prescribed time (typically 5-10 seconds). Release and repeat. This teaches proper glute activation and can be done anywhere to improve mind-muscle connection.',
  ),
  'single_leg_rdl_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'core': 0.5,
    },
    description: 'HOW TO: Perform a single leg RDL by balancing on one leg and hinging forward while extending the other leg behind you. When you reach the bottom position (torso parallel to floor), hold that position. Perform small pulsing movements (1-2 inches up and down) while maintaining the hinge. This intensifies the hamstring and glute stretch under constant tension. Complete pulses, then switch legs.',
  ),
  'glute_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep your core tight. Kick one leg straight back and up behind you, keeping the leg straight. Lift until your leg is in line with your body or slightly higher. Squeeze your glute at the top. Lower with control. Complete all reps, then switch legs.',
  ),
  'glute_kickbacks': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep your core tight. Kick one leg straight back and up behind you, keeping the leg straight. Lift until your leg is in line with your body or slightly higher. Squeeze your glute at the top. Lower with control. Complete all reps, then switch legs.',
  ),
  'cable_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Attach an ankle strap to a low cable pulley and secure it around your ankle. Face the machine and hold on for support. Keep your working leg straight or slightly bent. Kick your leg straight back and up by squeezing your glute. Keep your torso upright or slightly hinged forward. Squeeze at the top. Return with control. Complete all reps, then switch legs.',
  ),
  'standing_glute_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
      'hip_abductors': 0.6,
    },
    description: 'HOW TO: Stand upright holding onto something for balance. Keep your standing leg straight or slightly bent. Kick one leg straight back behind you, leading with your heel. Squeeze your glute hard at the top. Keep your torso upright - don\'t lean forward excessively. Lower with control. Can be done with cables, bands, or bodyweight. Complete all reps, then switch.',
  ),
  'donkey_kick': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep one knee bent at 90 degrees. Lift that leg by driving your heel straight up toward the ceiling, squeezing your glute. Keep your knee bent throughout - don\'t straighten the leg. Lift until your thigh is parallel to the floor or slightly above. Lower with control. Complete all reps, then switch legs.',
  ),
  'donkey_kicks': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep one knee bent at 90 degrees. Lift that leg by driving your heel straight up toward the ceiling, squeezing your glute. Keep your knee bent throughout - don\'t straighten the leg. Lift until your thigh is parallel to the floor or slightly above. Lower with control. Complete all reps, then switch legs.',
  ),
  'donkey_kick_pulse': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Get on all fours. Lift one leg into the top position of a donkey kick (knee bent, heel toward ceiling, thigh parallel to floor). Hold this position. Perform small pulsing movements up and down (1-2 inches) while keeping your knee bent. Maintain constant tension on your glute. After completing pulses, lower the leg. Switch sides.',
  ),
  'donkey_kick_pulses': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Get on all fours. Lift one leg into the top position of a donkey kick (knee bent, heel toward ceiling, thigh parallel to floor). Hold this position. Perform small pulsing movements up and down (1-2 inches) while keeping your knee bent. Maintain constant tension on your glute. After completing pulses, lower the leg. Switch sides.',
  ),
  'donkey_kicks_cable': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Attach an ankle strap to a low cable and secure it around one ankle. Get on all fours facing away from the machine. Keep your working knee bent at 90 degrees. Drive your heel up toward the ceiling against the cable resistance. Squeeze your glute at the top. Lower with control. The cable provides constant tension. Complete all reps, then switch legs.',
  ),
  'fire_hydrant': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hip_abductors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep your right knee bent at 90 degrees. Lift your right leg out to the side (abduction), keeping the knee bent. Raise your knee to hip height or as high as you can while keeping your torso stable. Squeeze your glute and outer hip at the top. Lower with control. Complete all reps, then switch legs.',
  ),
  'fire_hydrants': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hip_abductors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep your right knee bent at 90 degrees. Lift your right leg out to the side (abduction), keeping the knee bent. Raise your knee to hip height or as high as you can while keeping your torso stable. Squeeze your glute and outer hip at the top. Lower with control. Complete all reps, then switch legs.',
  ),
  'banded_fire_hydrant': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hip_abductors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Place a resistance band around your thighs just above your knees. Get on all fours. Lift one knee out to the side against the band resistance, keeping it bent at 90 degrees. Raise as high as possible while fighting the band. Squeeze your glute medius at the top. Lower with control. The band increases resistance and activation. Complete all reps, then switch.',
  ),
  'banded_clamshell': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hip_abductors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Place a resistance band around your thighs just above your knees. Lie on your side with hips and knees bent at 90 degrees, feet together. Rest your head on your lower arm. Keep your feet together throughout. Lift your top knee as high as possible against the band resistance. Hold at the top, squeezing your glute. Lower with control. Complete all reps, then switch sides.',
  ),
  'side_lying_leg_raise': ExerciseMuscleData(
    primaryMuscles: {
      'hip_abductors': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on your right side with legs straight and stacked. Rest your head on your lower arm, other hand on the floor for balance. Keep your top leg straight with toes pointed forward. Lift your top leg straight up toward the ceiling as high as you can. Hold briefly at the top. Lower with control without letting your legs touch. Complete all reps, then switch sides.',
  ),
  'banded_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Place a resistance band around your ankles. Stand holding something for balance. Keep your working leg straight. Kick it straight back behind you against the band resistance. Squeeze your glute at the top. Lower with control. The band provides constant tension throughout the movement. Complete all reps, then switch legs.',
  ),
  'cable_pull_through': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Attach a rope to a low cable pulley. Face away from the machine and straddle the cable, reaching between your legs to grab the rope with both hands. Step forward to create tension. Stand with feet shoulder-width apart. Hinge at the hips, pushing your butt back and letting the rope pull between your legs. Explosively drive your hips forward to stand. Squeeze glutes at top.',
  ),
  'cable_pullthrough': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Attach a rope to a low cable. Face away from the machine, straddle the cable, and grab the rope between your legs with both hands. Step forward to create tension. Hinge at hips, pushing your butt back. Explosively drive your hips forward to stand, squeezing glutes at top. This teaches proper hip hinge mechanics.',
  ),
  'pull_through': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Attach a rope to a low cable. Face away, straddle the cable, grab rope between legs. Step forward to create tension. Hinge at hips, pushing butt back. Explosively drive hips forward to stand. Squeeze glutes hard at top. This movement pattern mimics kettlebell swings and deadlifts.',
  ),
  'back_extension': ExerciseMuscleData(
    primaryMuscles: {
      'lower_back': 0.0,
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Position yourself in a back extension machine or Roman chair with hips at the pad edge. Cross arms over chest or behind head. Keep legs straight. Lower your torso by bending at the waist, going down as far as comfortable. Raise your torso back up by contracting your glutes, hamstrings, and lower back until your body forms a straight line. Don\'t hyperextend past straight.',
  ),
  'back_extensions': ExerciseMuscleData(
    primaryMuscles: {
      'lower_back': 0.0,
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Position yourself in a back extension machine or Roman chair with hips at the pad edge. Cross arms over chest or behind head. Keep legs straight. Lower your torso by bending at the waist, going down as far as comfortable. Raise your torso back up by contracting your glutes, hamstrings, and lower back until your body forms a straight line. Don\'t hyperextend past straight.',
  ),
  'hyperextension': ExerciseMuscleData(
    primaryMuscles: {
      'lower_back': 0.0,
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Position yourself in a hyperextension bench with hips resting on the pad. Cross arms over chest or behind head. Lower your torso below parallel to the floor by bending at the waist. Raise back up past parallel, extending slightly above horizontal. The extended range of motion (going below and above parallel) intensifies the work on your posterior chain.',
  ),
  'hyperextensions': ExerciseMuscleData(
    primaryMuscles: {
      'lower_back': 0.0,
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Position yourself in a hyperextension bench with hips resting on the pad. Cross arms over chest or behind head. Lower your torso below parallel to the floor by bending at the waist. Raise back up past parallel, extending slightly above horizontal. The extended range of motion intensifies the work on your posterior chain.',
  ),
  'reverse_hyper': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie face down on a reverse hyperextension machine (or regular bench) with your hips at the edge and legs hanging off. Grip the handles or bench for stability. Swing your legs up behind you by contracting your glutes and hamstrings, raising them as high as comfortable. Squeeze at the top. Lower with control. This unique movement decompresses the spine while building the posterior chain.',
  ),
  'curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells, a barbell, or cable handle with palms facing up (supinated grip). Keep your elbows at your sides and upper arms stationary. Curl the weight up by bending your elbows, bringing the weight toward your shoulders. Squeeze your biceps at the top. Lower with control. Don\'t swing or use momentum.',
  ),
  'curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells, a barbell, or cable handle with palms facing up. Keep your elbows at your sides and upper arms stationary. Curl the weight up by bending your elbows, bringing the weight toward your shoulders. Squeeze your biceps at the top. Lower with control. Don\'t swing or use momentum.',
  ),
  'bicep_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Hold dumbbells at your sides or a barbell in front of your thighs with palms facing forward. Keep elbows pinned to your sides. Curl the weight up by bending elbows, bringing weight toward shoulders. Squeeze biceps at the top. Lower with control to full extension. Keep upper arms still throughout.',
  ),
  'bicep_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Hold dumbbells at your sides or a barbell in front of your thighs with palms facing forward. Keep elbows pinned to your sides. Curl the weight up by bending elbows, bringing weight toward shoulders. Squeeze biceps at the top. Lower with control to full extension. Keep upper arms still throughout.',
  ),
  'barbell_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, holding a barbell with an underhand grip (palms up), hands about shoulder-width apart. Let the bar hang at arm\'s length. Keep your elbows pinned at your sides. Curl the bar up toward your shoulders by bending your elbows. Squeeze your biceps at the top. Lower with control to full extension. Don\'t swing your body.',
  ),
  'barbell_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, holding a barbell with an underhand grip (palms up), hands about shoulder-width apart. Let the bar hang at arm\'s length. Keep your elbows pinned at your sides. Curl the bar up toward your shoulders by bending your elbows. Squeeze your biceps at the top. Lower with control to full extension. Don\'t swing your body.',
  ),
  'barbell_bicep_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell with an underhand grip, hands shoulder-width. Let bar hang at arm\'s length. Keep elbows at your sides. Curl the bar up toward shoulders by bending elbows. Squeeze biceps at top. Lower with control to full extension. The barbell allows maximum loading for bicep strength and mass.',
  ),
  'dumbbell_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward. Keep your elbows pinned at your sides. Curl the dumbbells up toward your shoulders by bending your elbows. You can curl both arms simultaneously or alternating. Squeeze biceps at the top. Lower with control. Dumbbells allow independent arm movement and help address imbalances.',
  ),
  'dumbbell_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward. Keep your elbows pinned at your sides. Curl the dumbbells up toward your shoulders by bending your elbows. You can curl both arms simultaneously or alternating. Squeeze biceps at the top. Lower with control. Dumbbells allow independent arm movement.',
  ),
  'dumbbell_bicep_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward. Keep elbows pinned at your sides. Curl dumbbells up toward shoulders. Squeeze biceps at top. Lower with control to full extension. Keep upper arms stationary throughout the movement.',
  ),
  'hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing your body (neutral grip - palms facing each other). Keep elbows pinned at your sides. Curl the dumbbells up toward your shoulders while maintaining the neutral grip throughout. Squeeze at the top. Lower with control. The neutral grip targets the brachialis and brachioradialis more than standard curls, building arm thickness.',
  ),
  'hammer_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing your body (neutral grip). Keep elbows pinned at your sides. Curl the dumbbells up toward your shoulders while maintaining the neutral grip throughout. Squeeze at the top. Lower with control. The neutral grip targets the brachialis and brachioradialis.',
  ),
  'standing_hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold dumbbells at your sides with a neutral grip (palms facing each other). Keep elbows at your sides. Curl the weights up toward shoulders, maintaining neutral grip. Squeeze at top. Lower with control. Standing allows natural body positioning for maximum strength.',
  ),
  'seated_hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench with back support. Hold dumbbells at your sides with a neutral grip (palms facing each other). Keep elbows at your sides. Curl dumbbells up toward shoulders, keeping palms facing each other. Squeeze at top. Lower with control. Seated eliminates momentum and body sway for stricter isolation.',
  ),
'cross_body_hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,     // Brachialis heavily targeted
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: Stand holding a dumbbell in one hand at your side with a neutral grip (palm facing your body). Keep your elbow pinned to your side. Curl the dumbbell up across your body toward the opposite shoulder, maintaining the neutral grip throughout the movement. Squeeze hard at the peak contraction. Lower with control back to the starting position. The cross-body motion provides a unique angle that maximally engages the brachialis, building arm thickness and peak. Complete all reps on one side before switching.',
  ),
  'preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Sit at a preacher bench with your armpits resting on the top edge and upper arms flat on the pad. Hold a barbell or dumbbells with an underhand grip. Fully extend your arms at the bottom. Curl the weight up by flexing your biceps, keeping your upper arms pressed firmly against the pad. Squeeze hard at the top. Lower with slow, controlled motion until arms are fully extended. The preacher bench isolates the biceps by eliminating momentum and shoulder involvement, targeting the lower biceps insertion particularly well.',
  ),
  'preacher_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Sit at a preacher bench with your armpits resting on the top edge and upper arms flat on the pad. Hold a barbell or dumbbells with an underhand grip. Fully extend your arms at the bottom. Curl the weight up by flexing your biceps, keeping your upper arms pressed firmly against the pad. Squeeze hard at the top. Lower with slow, controlled motion until arms are fully extended. The preacher bench isolates the biceps by eliminating momentum and shoulder involvement, targeting the lower biceps insertion particularly well.',
  ),
  'preacher_curl_machine': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Adjust the seat height so your armpits rest comfortably on the top of the pad. Place your upper arms flat on the pad and grip the handles with an underhand grip. Fully extend your arms to start. Curl the handles up by contracting your biceps, keeping your upper arms pressed into the pad throughout. Squeeze at the peak contraction. Lower with control until arms are fully extended. The machine provides constant tension and eliminates stabilization demands, allowing maximum bicep isolation and safety.',
  ),
  'concentration_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Sit on a bench with legs spread wide. Hold a dumbbell in one hand and brace the back of that upper arm against your inner thigh, just above the knee. Lean forward slightly. Start with your arm fully extended, palm facing away from your thigh. Curl the dumbbell up toward your shoulder by flexing your biceps, keeping your upper arm completely stationary against your thigh. Squeeze hard at the top. Lower with control to full extension. Complete all reps before switching arms. This exercise maximally isolates the biceps by eliminating all momentum and swing.',
  ),
  'concentration_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Sit on a bench with legs spread wide. Hold a dumbbell in one hand and brace the back of that upper arm against your inner thigh, just above the knee. Lean forward slightly. Start with your arm fully extended, palm facing away from your thigh. Curl the dumbbell up toward your shoulder by flexing your biceps, keeping your upper arm completely stationary against your thigh. Squeeze hard at the top. Lower with control to full extension. Complete all reps before switching arms. This exercise maximally isolates the biceps by eliminating all momentum and swing.',
  ),
  'cable_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand facing a low cable pulley with feet shoulder-width apart. Grab the cable handle or bar with an underhand grip. Take a step back for tension. Keep elbows pinned at your sides and upper arms stationary. Curl the handle up toward your shoulders by contracting your biceps. Squeeze hard at the peak. Lower with control, resisting the weight as your arms return to full extension. Do not lean back. The cable provides constant tension throughout the entire range of motion, maximizing bicep engagement unlike free weights where tension varies.',
  ),
  'cable_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand facing a low cable pulley with feet shoulder-width apart. Grab the cable handle or bar with an underhand grip. Take a step back for tension. Keep elbows pinned at your sides and upper arms stationary. Curl the handle up toward your shoulders by contracting your biceps. Squeeze hard at the peak. Lower with control, resisting the weight as your arms return to full extension. Do not lean back. The cable provides constant tension throughout the entire range of motion, maximizing bicep engagement unlike free weights where tension varies.',
  ),
  'cable_bicep_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand facing a low cable pulley with feet shoulder-width apart. Grab the cable handle or bar with an underhand grip. Take a step back for tension. Keep elbows pinned at your sides and upper arms stationary. Curl the handle up toward your shoulders by contracting your biceps. Squeeze hard at the peak. Lower with control, resisting the weight as your arms return to full extension. Do not lean back. The cable provides constant tension throughout the entire range of motion, maximizing bicep engagement unlike free weights where tension varies.',
  ),
  'incline_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Set an incline bench to 45-60 degrees. Sit back with your upper back and head supported on the bench. Hold dumbbells at your sides with arms fully extended, letting them hang straight down behind your torso. Keep palms facing forward (supinated grip). Curl both dumbbells up toward your shoulders by flexing your biceps, keeping your upper arms stationary and perpendicular to the floor. Squeeze at the top. Lower with control to full stretch. The incline position places maximum stretch on the biceps at the bottom, targeting the long head for peak development.',
  ),
  'incline_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Set an incline bench to 45-60 degrees. Sit back with your upper back and head supported on the bench. Hold dumbbells at your sides with arms fully extended, letting them hang straight down behind your torso. Keep palms facing forward (supinated grip). Curl both dumbbells up toward your shoulders by flexing your biceps, keeping your upper arms stationary and perpendicular to the floor. Squeeze at the top. Lower with control to full stretch. The incline position places maximum stretch on the biceps at the bottom, targeting the long head for peak development.',
  ),
  'spider_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Set an incline bench to about 45 degrees. Lie face down on the bench with your chest against the pad and arms hanging straight down over the top edge. Hold dumbbells or a barbell with an underhand grip. Curl the weight up toward your face by contracting your biceps, keeping your upper arms perpendicular to the floor. Squeeze hard at the top. Lower with control to full extension. The prone position eliminates momentum completely and provides peak contraction at the top, maximally isolating the biceps and targeting the short head.',
  ),
  'spider_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Set an incline bench to about 45 degrees. Lie face down on the bench with your chest against the pad and arms hanging straight down over the top edge. Hold dumbbells or a barbell with an underhand grip. Curl the weight up toward your face by contracting your biceps, keeping your upper arms perpendicular to the floor. Squeeze hard at the top. Lower with control to full extension. The prone position eliminates momentum completely and provides peak contraction at the top, maximally isolating the biceps and targeting the short head.',
  ),
  'ez_bar_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand holding an EZ curl bar with a shoulder-width grip on the angled portions. Keep feet shoulder-width apart and core tight. Start with arms fully extended at your thighs. Keep elbows pinned at your sides. Curl the bar up toward your chest by flexing your biceps, following the natural path the EZ bar dictates. Squeeze hard at the top. Lower with control to full extension. The angled grip of the EZ bar reduces wrist strain compared to straight bars while effectively targeting both bicep heads.',
  ),
  'ez_bar_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand holding an EZ curl bar with a shoulder-width grip on the angled portions. Keep feet shoulder-width apart and core tight. Start with arms fully extended at your thighs. Keep elbows pinned at your sides. Curl the bar up toward your chest by flexing your biceps, following the natural path the EZ bar dictates. Squeeze hard at the top. Lower with control to full extension. The angled grip of the EZ bar reduces wrist strain compared to straight bars while effectively targeting both bicep heads.',
  ),
  '21s_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Hold a barbell or dumbbells with an underhand grip. This is a three-part movement: First, perform 7 reps from full extension to halfway up (90-degree elbow angle). Then, immediately perform 7 reps from halfway to full contraction at the top. Finally, perform 7 full range of motion reps from bottom to top. Keep elbows pinned at sides throughout all 21 reps. This advanced technique hammers the biceps through partial and full ranges for extreme metabolic stress and pump.',
  ),
  'reverse_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,      // Brachioradialis primary
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: Stand holding a barbell or dumbbells with an overhand grip (palms facing down), hands shoulder-width apart. Keep elbows pinned at your sides. Curl the weight up toward your shoulders by flexing your arms, maintaining the overhand grip throughout. Squeeze at the top. Lower with control to full extension. The overhand grip shifts emphasis from the biceps to the brachioradialis (top of forearm) and brachialis, building impressive forearm size and grip strength.',
  ),
  'reverse_curls': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,      // Brachioradialis primary
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: Stand holding a barbell or dumbbells with an overhand grip (palms facing down), hands shoulder-width apart. Keep elbows pinned at your sides. Curl the weight up toward your shoulders by flexing your arms, maintaining the overhand grip throughout. Squeeze at the top. Lower with control to full extension. The overhand grip shifts emphasis from the biceps to the brachioradialis (top of forearm) and brachialis, building impressive forearm size and grip strength.',
  ),
  'zottman_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward (supinated). Curl the dumbbells up toward your shoulders with this underhand grip, contracting your biceps. At the top, rotate your wrists 180 degrees so palms now face down (pronated). Lower the dumbbells slowly with this overhand grip, working the forearms. At the bottom, rotate palms back to facing up and repeat. This unique rotation trains both biceps (concentric with supination) and forearms (eccentric with pronation) in one movement.',
  ),
  'zottman_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward (supinated). Curl the dumbbells up toward your shoulders with this underhand grip, contracting your biceps. At the top, rotate your wrists 180 degrees so palms now face down (pronated). Lower the dumbbells slowly with this overhand grip, working the forearms. At the bottom, rotate palms back to facing up and repeat. This unique rotation trains both biceps (concentric with supination) and forearms (eccentric with pronation) in one movement.',
  ),
  '21s': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Hold a barbell or dumbbells with an underhand grip. This is a three-part movement: First, perform 7 reps from full extension to halfway up (90-degree elbow angle). Then, immediately perform 7 reps from halfway to full contraction at the top. Finally, perform 7 full range of motion reps from bottom to top. Keep elbows pinned at sides throughout all 21 reps. This advanced technique hammers the biceps through partial and full ranges for extreme metabolic stress and pump.',
  ),
  'tricep_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: This can be performed standing, seated, or lying. Hold a dumbbell overhead with both hands, or use a cable/machine. Start with arms fully extended above your head. Keep elbows pointing forward and upper arms stationary. Lower the weight behind your head by bending only at the elbows until you feel a deep stretch in your triceps. Extend back to the starting position by contracting your triceps. The overhead position maximally stretches and targets the long head of the triceps.',
  ),
  'tricep_extensions': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: This can be performed standing, seated, or lying. Hold a dumbbell overhead with both hands, or use a cable/machine. Start with arms fully extended above your head. Keep elbows pointing forward and upper arms stationary. Lower the weight behind your head by bending only at the elbows until you feel a deep stretch in your triceps. Extend back to the starting position by contracting your triceps. The overhead position maximally stretches and targets the long head of the triceps.',
  ),
  'overhead_tricep_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand or sit with core braced. Hold a dumbbell overhead with both hands gripping one end, or use a cable attachment. Start with arms fully extended overhead. Keep elbows pointing forward and close together. Lower the weight behind your head by bending only at the elbows, keeping upper arms stationary. Lower until you feel a full stretch in your triceps. Extend back up by contracting your triceps until arms are fully extended. This overhead angle places maximum stretch on the long head of the triceps.',
  ),
  'overhead_tricep': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand or sit with core braced. Hold a dumbbell overhead with both hands gripping one end, or use a cable attachment. Start with arms fully extended overhead. Keep elbows pointing forward and close together. Lower the weight behind your head by bending only at the elbows, keeping upper arms stationary. Lower until you feel a full stretch in your triceps. Extend back up by contracting your triceps until arms are fully extended. This overhead angle places maximum stretch on the long head of the triceps.',
  ),
  'overhead_tricep_ext': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand or sit with core braced. Hold a dumbbell overhead with both hands gripping one end, or use a cable attachment. Start with arms fully extended overhead. Keep elbows pointing forward and close together. Lower the weight behind your head by bending only at the elbows, keeping upper arms stationary. Lower until you feel a full stretch in your triceps. Extend back up by contracting your triceps until arms are fully extended. This overhead angle places maximum stretch on the long head of the triceps.',
  ),
  'tricep_pushdown': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand facing a high cable pulley with feet shoulder-width apart. Grab the bar or rope attachment with an overhand grip. Pin your elbows at your sides and keep upper arms stationary. Start with forearms parallel to the floor. Push the attachment down by extending your elbows until your arms are fully straight. Squeeze your triceps hard at the bottom. Control the weight back up, stopping when forearms are parallel to the floor. Keep your body still - no leaning or using momentum. Cable pushdowns isolate the triceps effectively with constant tension.',
  ),
  'tricep_pushdowns': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand facing a high cable pulley with feet shoulder-width apart. Grab the bar or rope attachment with an overhand grip. Pin your elbows at your sides and keep upper arms stationary. Start with forearms parallel to the floor. Push the attachment down by extending your elbows until your arms are fully straight. Squeeze your triceps hard at the bottom. Control the weight back up, stopping when forearms are parallel to the floor. Keep your body still - no leaning or using momentum. Cable pushdowns isolate the triceps effectively with constant tension.',
  ),
  'cable_pushdown': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand facing a high cable pulley with feet shoulder-width apart. Grab the bar or rope attachment with an overhand grip. Pin your elbows at your sides and keep upper arms stationary. Start with forearms parallel to the floor. Push the attachment down by extending your elbows until your arms are fully straight. Squeeze your triceps hard at the bottom. Control the weight back up, stopping when forearms are parallel to the floor. Keep your body still - no leaning or using momentum. Cable pushdowns isolate the triceps effectively with constant tension.',
  ),
  'rope_pushdown': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand facing a high cable pulley with feet shoulder-width apart. Grab both ends of a rope attachment with a neutral grip (palms facing each other). Pin your elbows at your sides. Start with forearms parallel to the floor. Push the rope down by extending your elbows while simultaneously pulling the rope ends apart at the bottom, turning your hands outward. Squeeze your triceps maximally at the bottom. Control the weight back up. The rope allows for natural wrist rotation and provides extra contraction at the bottom.',
  ),
  'rope_pushdowns': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand facing a high cable pulley with feet shoulder-width apart. Grab both ends of a rope attachment with a neutral grip (palms facing each other). Pin your elbows at your sides. Start with forearms parallel to the floor. Push the rope down by extending your elbows while simultaneously pulling the rope ends apart at the bottom, turning your hands outward. Squeeze your triceps maximally at the bottom. Control the weight back up. The rope allows for natural wrist rotation and provides extra contraction at the bottom.',
  ),
  'rope_tricep_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand facing a high cable pulley with feet shoulder-width apart. Grab both ends of a rope attachment with a neutral grip (palms facing each other). Pin your elbows at your sides. Start with forearms parallel to the floor. Push the rope down by extending your elbows while simultaneously pulling the rope ends apart at the bottom, turning your hands outward. Squeeze your triceps maximally at the bottom. Control the weight back up. The rope allows for natural wrist rotation and provides extra contraction at the bottom.',
  ),
  'skull_crusher': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie flat on a bench holding a barbell or EZ bar with arms fully extended above your chest. Keep upper arms stationary and angled slightly back toward your head. Lower the bar by bending only at the elbows, bringing the bar down toward your forehead or just behind your head. Keep elbows pointing up, not flaring out. Extend back up to the starting position by contracting your triceps powerfully. The angle places maximum stretch and tension on the triceps, particularly the long head.',
  ),
  'skull_crushers': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie flat on a bench holding a barbell or EZ bar with arms fully extended above your chest. Keep upper arms stationary and angled slightly back toward your head. Lower the bar by bending only at the elbows, bringing the bar down toward your forehead or just behind your head. Keep elbows pointing up, not flaring out. Extend back up to the starting position by contracting your triceps powerfully. The angle places maximum stretch and tension on the triceps, particularly the long head.',
  ),
  'tricep_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.5,
      'lats': 0.6,
    },
    description: 'HOW TO: Stand with one knee and hand on a bench for support, torso parallel to the floor. Hold a dumbbell in the other hand. Pin your elbow at your side with upper arm parallel to the floor. Start with forearm hanging down (elbow bent 90 degrees). Extend the elbow by contracting your triceps, driving the dumbbell back until your arm is fully straight and parallel to the floor. Squeeze hard at full extension. Lower with control. Complete all reps before switching arms. Kickbacks provide peak contraction at lockout.',
  ),
  'tricep_kickbacks': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.5,
      'lats': 0.6,
    },
    description: 'HOW TO: Stand with one knee and hand on a bench for support, torso parallel to the floor. Hold a dumbbell in the other hand. Pin your elbow at your side with upper arm parallel to the floor. Start with forearm hanging down (elbow bent 90 degrees). Extend the elbow by contracting your triceps, driving the dumbbell back until your arm is fully straight and parallel to the floor. Squeeze hard at full extension. Lower with control. Complete all reps before switching arms. Kickbacks provide peak contraction at lockout.',
  ),
  'dumbbell_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.5,
      'lats': 0.6,
    },
    description: 'HOW TO: Stand with one knee and hand on a bench for support, torso parallel to the floor. Hold a dumbbell in the other hand. Pin your elbow at your side with upper arm parallel to the floor. Start with forearm hanging down (elbow bent 90 degrees). Extend the elbow by contracting your triceps, driving the dumbbell back until your arm is fully straight and parallel to the floor. Squeeze hard at full extension. Lower with control. Complete all reps before switching arms. Kickbacks provide peak contraction at lockout.',
  ),
  'cable_tricep_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand facing a high cable pulley with feet shoulder-width apart. Grab the attachment with an overhand or neutral grip. Pin your elbows at your sides and keep upper arms stationary. Start with forearms parallel to the floor. Push the attachment down by extending your elbows until your arms are fully straight. Squeeze your triceps hard at the bottom. Control the weight back up to the starting position. The cable provides constant tension throughout the entire range of motion, making it superior to free weights for tricep isolation.',
  ),
  'leg_extension': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a leg extension machine with your back against the pad. Position your ankles under the lower roller pad, with knees aligned with the pivot point. Grip the handles for stability. Extend your legs by contracting your quads, lifting the pad until your legs are fully straight. Squeeze your quads hard at the top. Lower with control back to the starting position, stopping just before the weight stack touches. Leg extensions purely isolate the quadriceps, particularly effective for developing the vastus medialis (teardrop).',
  ),
  'leg_extensions': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a leg extension machine with your back against the pad. Position your ankles under the lower roller pad, with knees aligned with the pivot point. Grip the handles for stability. Extend your legs by contracting your quads, lifting the pad until your legs are fully straight. Squeeze your quads hard at the top. Lower with control back to the starting position, stopping just before the weight stack touches. Leg extensions purely isolate the quadriceps, particularly effective for developing the vastus medialis (teardrop).',
  ),
  'leg_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Position yourself in a leg curl machine (lying, seated, or standing variant). Secure your ankles under the roller pad with knees just off the edge of the bench. Grip the handles. Curl your heels toward your glutes by contracting your hamstrings, lifting the pad through a full range of motion. Squeeze hard at the peak contraction. Lower with control, resisting the weight. Leg curls isolate the hamstrings effectively and are essential for balanced leg development and knee injury prevention.',
  ),
  'leg_curls': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Position yourself in a leg curl machine (lying, seated, or standing variant). Secure your ankles under the roller pad with knees just off the edge of the bench. Grip the handles. Curl your heels toward your glutes by contracting your hamstrings, lifting the pad through a full range of motion. Squeeze hard at the peak contraction. Lower with control, resisting the weight. Leg curls isolate the hamstrings effectively and are essential for balanced leg development and knee injury prevention.',
  ),
  'hamstring_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Position yourself in a leg curl machine (lying, seated, or standing variant). Secure your ankles under the roller pad with knees just off the edge of the bench. Grip the handles. Curl your heels toward your glutes by contracting your hamstrings, lifting the pad through a full range of motion. Squeeze hard at the peak contraction. Lower with control, resisting the weight. Hamstring curls isolate the hamstrings effectively and are essential for balanced leg development and knee injury prevention.',
  ),
  'hamstring_curls': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Position yourself in a leg curl machine (lying, seated, or standing variant). Secure your ankles under the roller pad with knees just off the edge of the bench. Grip the handles. Curl your heels toward your glutes by contracting your hamstrings, lifting the pad through a full range of motion. Squeeze hard at the peak contraction. Lower with control, resisting the weight. Hamstring curls isolate the hamstrings effectively and are essential for balanced leg development and knee injury prevention.',
  ),
  'lying_leg_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Lie face down on a leg curl machine with your ankles hooked under the roller pad. Align your knees just off the edge of the bench. Grip the handles. Curl your heels toward your glutes by contracting your hamstrings, bringing the pad up as far as possible. Squeeze hard at the peak. Lower with control, fully extending but not locking out. The lying position isolates the hamstrings effectively and minimizes lower back involvement.',
  ),
  'seated_leg_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Sit in a seated leg curl machine with your back against the pad. Position your ankles on top of the lower roller pad. Secure the thigh pad over your quads, just above your knees. Grip the handles. Curl your heels down and under the seat by contracting your hamstrings. Squeeze hard at the bottom. Extend back up with control. The seated position provides a greater stretch on the hamstrings compared to lying variations and targets the lower portion effectively.',
  ),
  'nordic_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'core': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Kneel on a pad with ankles anchored securely (under a barbell, held by a partner, or in a Nordic curl device). Keep your hips extended and body straight from shoulders to knees. Cross your arms over your chest or hold them in front. Slowly lower your torso forward by resisting with your hamstrings, maintaining a straight body line. Lower as far as you can control. Use your hands to catch yourself at the bottom. Push off the floor to return to the starting position, or pull yourself back up with pure hamstring strength if possible. Nordic curls are one of the most effective exercises for hamstring strength and injury prevention.',
  ),
  'nordic_curls': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'core': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Kneel on a pad with ankles anchored securely (under a barbell, held by a partner, or in a Nordic curl device). Keep your hips extended and body straight from shoulders to knees. Cross your arms over your chest or hold them in front. Slowly lower your torso forward by resisting with your hamstrings, maintaining a straight body line. Lower as far as you can control. Use your hands to catch yourself at the bottom. Push off the floor to return to the starting position, or pull yourself back up with pure hamstring strength if possible. Nordic curls are one of the most effective exercises for hamstring strength and injury prevention.',
  ),
  'wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding a barbell or dumbbells with an underhand grip (palms up). Rest your forearms on your thighs or on the bench, with wrists hanging just beyond your knees. Let the weight roll down toward your fingertips to fully extend your wrists. Curl your wrists up by contracting your forearm flexors, bringing the weight up as high as possible. Squeeze at the top. Lower with control. Wrist curls target the forearm flexors on the underside of the forearm, building grip strength and forearm size.',
  ),
  'wrist_curls': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding a barbell or dumbbells with an underhand grip (palms up). Rest your forearms on your thighs or on the bench, with wrists hanging just beyond your knees. Let the weight roll down toward your fingertips to fully extend your wrists. Curl your wrists up by contracting your forearm flexors, bringing the weight up as high as possible. Squeeze at the top. Lower with control. Wrist curls target the forearm flexors on the underside of the forearm, building grip strength and forearm size.',
  ),
'reverse_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,     // Extensors on top of forearm
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding a barbell or dumbbells with an overhand grip (palms down). Rest your forearms on your thighs or on the bench, with wrists hanging just beyond your knees. Start with wrists in a flexed position. Extend your wrists upward by contracting your forearm extensors, lifting the weight as high as possible. Squeeze at the top. Lower with control. Reverse wrist curls target the forearm extensors on the top of the forearm, balancing out wrist curl work and preventing imbalances.',
  ),
  'high_knee': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Stand tall with feet hip-width apart. Drive one knee up toward your chest as high as possible while keeping your core tight and chest up. Land on the ball of your foot and immediately drive the opposite knee up. Continue alternating in a running motion. Pump your arms in coordination with your legs. Maintain an upright posture throughout. High knees are an excellent warm-up and cardio exercise that builds hip flexor strength, improves running form, and elevates heart rate.',
  ),
  'high_knees': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Stand tall with feet hip-width apart. Drive one knee up toward your chest as high as possible while keeping your core tight and chest up. Land on the ball of your foot and immediately drive the opposite knee up. Continue alternating in a running motion. Pump your arms in coordination with your legs. Maintain an upright posture throughout. High knees are an excellent warm-up and cardio exercise that builds hip flexor strength, improves running form, and elevates heart rate.',
  ),
  'high_knee_sprint': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.5,
      'calves': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Stand tall with feet hip-width apart. Explosively drive one knee up toward your chest as high and as fast as possible. Immediately plant that foot and drive the opposite knee up with maximum speed. Continue alternating at sprint pace. Pump your arms powerfully in coordination. Stay on the balls of your feet. Maintain an upright posture with engaged core. High knee sprints combine cardio intensity with explosive power development for the hip flexors and quads.',
  ),
  'marching_in_place': ExerciseMuscleData(
    primaryMuscles: {
      'hip_flexors': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'calves': 0.6,
    },
    description: 'HOW TO: Stand tall with feet hip-width apart, core engaged. Lift one knee up to hip height while keeping your back straight and chest up. Lower it back down with control and immediately lift the opposite knee. Continue alternating in a controlled marching motion. Swing your arms naturally in opposition to your legs. Keep the movement deliberate and controlled. Marching in place is a low-impact warm-up that activates the hip flexors and core.',
  ),
  'running_in_place': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart. Begin running in place by lifting your knees to a comfortable height while landing on the balls of your feet. Pump your arms in coordination with your legs as if running normally. Maintain an upright posture with engaged core. Keep a steady rhythm. Running in place is an effective cardio warm-up that elevates heart rate without requiring space, preparing the body for more intense activity.',
  ),
  'knee_tap': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
    },
    description: 'HOW TO: Stand tall with feet shoulder-width apart. Lift one knee up toward your chest. Reach across with the opposite hand and tap the top of your knee. Lower the leg back down with control and repeat on the other side. Keep your core engaged and maintain balance. Knee taps improve coordination, hip mobility, and core stability while providing a dynamic warm-up.',
  ),
  'a_skip': ExerciseMuscleData(
    primaryMuscles: {
      'hip_flexors': 0.0,
      'calves': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'core': 0.5,
    },
    description: 'HOW TO: Start in a tall athletic stance. Drive one knee up to hip height while simultaneously pushing off the ground with the opposite foot, hopping slightly. As the lifted knee reaches peak height, extend that leg downward and pull through with your hamstring to land on the ball of your foot. Immediately transition to the other side in a rhythmic skipping motion. Pump your arms in coordination. A-skips are a track and field drill that develops explosive hip flexion, ankle stiffness, and proper running mechanics.',
  ),
  'b_skip': ExerciseMuscleData(
    primaryMuscles: {
      'hip_flexors': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'calves': 0.5,
      'core': 0.5,
    },
    description: 'HOW TO: Start in a tall athletic stance. Drive one knee up to hip height. Extend that leg forward, then aggressively pull it down and back using your hamstring in a "pawing" motion, landing on the ball of your foot. Hop slightly as you transition to the other side. Continue in a rhythmic skipping pattern. Pump your arms. B-skips are an advanced running drill that emphasizes hamstring engagement and proper ground contact mechanics for sprinting.',
  ),
  'step_touch': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet together. Step to the right with your right foot, then bring your left foot to meet it, tapping the floor. Immediately step to the left with your left foot, bringing your right foot to tap. Continue alternating side to side in a rhythmic pattern. Keep knees slightly bent and core engaged. Swing your arms naturally. Step touch is a simple cardio movement that improves lateral coordination and gets the heart rate up.',
  ),
  'side_step': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'adductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand in an athletic stance with feet shoulder-width apart, knees slightly bent. Step laterally to the right with your right foot, then follow with your left foot, maintaining your stance width. Continue stepping laterally for the desired distance or reps. Keep your weight on the balls of your feet, chest up, and core engaged. Avoid crossing your feet. Repeat in the opposite direction. Side steps activate the glutes and improve lateral movement patterns.',
  ),
  'lateral_shuffle': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'adductors': 0.5,
      'abductors': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand in an athletic stance with feet shoulder-width apart, knees bent, and weight on the balls of your feet. Push off with your outside foot and explosively shuffle laterally, keeping your feet wide and maintaining low athletic position. Your feet should quickly touch the ground in a shuffle pattern without crossing. Stay low throughout. Repeat for distance or time. Lateral shuffles develop lateral quickness, glute strength, and defensive positioning for sports.',
  ),
  'skater': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Stand on one leg with slight knee bend. Jump laterally to the opposite side, landing on the opposite foot with knee bent. Let your landing leg absorb the impact while swinging your opposite leg behind you (like a speed skater). Immediately push off and jump back to the other side. Continue alternating in a fluid motion. Swing your arms across your body for momentum and balance. Skaters build single-leg power, lateral explosiveness, and cardiovascular endurance.',
  ),
  'skaters': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Stand on one leg with slight knee bend. Jump laterally to the opposite side, landing on the opposite foot with knee bent. Let your landing leg absorb the impact while swinging your opposite leg behind you (like a speed skater). Immediately push off and jump back to the other side. Continue alternating in a fluid motion. Swing your arms across your body for momentum and balance. Skaters build single-leg power, lateral explosiveness, and cardiovascular endurance.',
  ),
  'mountain_climber': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'quads': 0.5,
      'chest': 0.6,
    },
    description: 'HOW TO: Start in a high plank position with hands directly under shoulders, body in a straight line from head to heels. Engage your core. Drive one knee toward your chest, then quickly switch legs, extending the first leg back while bringing the opposite knee forward. Continue alternating legs in a running motion while maintaining plank position. Keep hips level and core tight throughout. Mountain climbers combine core stability with cardio intensity and hip flexor engagement.',
  ),
  'mountain_climbers': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'quads': 0.5,
      'chest': 0.6,
    },
    description: 'HOW TO: Start in a high plank position with hands directly under shoulders, body in a straight line from head to heels. Engage your core. Drive one knee toward your chest, then quickly switch legs, extending the first leg back while bringing the opposite knee forward. Continue alternating legs in a running motion while maintaining plank position. Keep hips level and core tight throughout. Mountain climbers combine core stability with cardio intensity and hip flexor engagement.',
  ),
  'mountain_climber_crossover': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques especially
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'quads': 0.5,
      'chest': 0.6,
    },
    description: 'HOW TO: Start in a high plank position with hands under shoulders. Drive one knee toward the opposite elbow, crossing under your body and rotating slightly through your torso. Return to plank and repeat with the opposite leg crossing toward the opposite elbow. Continue alternating in a controlled rhythm. Keep your hips relatively level and core engaged. Crossover mountain climbers emphasize the obliques and rotational core strength more than standard mountain climbers.',
  ),
  'leg_raise': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie flat on your back with legs extended and arms by your sides or hands under your glutes for support. Keep your lower back pressed to the floor. Engage your core and lift both legs up toward the ceiling, keeping them as straight as possible. Raise until your legs are perpendicular to the floor. Slowly lower them back down with control, stopping just before your feet touch the floor. Avoid arching your lower back. Leg raises target the lower abs and hip flexors with pure hip flexion.',
  ),
  'leg_raises': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie flat on your back with legs extended and arms by your sides or hands under your glutes for support. Keep your lower back pressed to the floor. Engage your core and lift both legs up toward the ceiling, keeping them as straight as possible. Raise until your legs are perpendicular to the floor. Slowly lower them back down with control, stopping just before your feet touch the floor. Avoid arching your lower back. Leg raises target the lower abs and hip flexors with pure hip flexion.',
  ),
  'lying_leg_raise': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie flat on your back with legs extended and arms by your sides or hands under your glutes for support. Keep your lower back pressed to the floor. Engage your core and lift both legs up toward the ceiling, keeping them as straight as possible. Raise until your legs are perpendicular to the floor. Slowly lower them back down with control, stopping just before your feet touch the floor. Avoid arching your lower back. Lying leg raises target the lower abs and hip flexors effectively.',
  ),
  'hanging_leg_raise': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'lats': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip, arms fully extended. Engage your core and minimize swinging. Keeping your legs relatively straight, lift them up in front of you by flexing your hips and contracting your abs. Raise your legs until they are parallel to the ground or higher. Hold briefly at the top. Lower with control back to the starting position. Hanging leg raises are an advanced movement that builds incredible core strength and grip endurance.',
  ),
  'hanging_leg_raises': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'lats': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with an overhand grip, arms fully extended. Engage your core and minimize swinging. Keeping your legs relatively straight, lift them up in front of you by flexing your hips and contracting your abs. Raise your legs until they are parallel to the ground or higher. Hold briefly at the top. Lower with control back to the starting position. Hanging leg raises are an advanced movement that builds incredible core strength and grip endurance.',
  ),
  'v_up': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Lie flat on your back with arms extended overhead and legs straight. Simultaneously lift your legs and upper body off the floor, reaching your hands toward your toes. Your body should form a "V" shape at the top. Contract your abs hard at the peak. Lower back down with control to the starting position. Keep your core engaged throughout to protect your lower back. V-ups are an advanced core exercise that targets the entire abdominal wall through simultaneous hip and trunk flexion.',
  ),
  'v_ups': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Lie flat on your back with arms extended overhead and legs straight. Simultaneously lift your legs and upper body off the floor, reaching your hands toward your toes. Your body should form a "V" shape at the top. Contract your abs hard at the peak. Lower back down with control to the starting position. Keep your core engaged throughout to protect your lower back. V-ups are an advanced core exercise that targets the entire abdominal wall through simultaneous hip and trunk flexion.',
  ),
  'bicycle_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques and abs
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
    },
    description: 'HOW TO: Lie on your back with hands behind your head (not pulling your neck) and legs extended. Lift your shoulders off the ground. Bring one knee toward your chest while rotating your torso to bring the opposite elbow toward that knee. Simultaneously extend the other leg out straight, hovering above the floor. Switch sides in a continuous pedaling motion. Keep your core engaged and avoid pulling on your neck. Bicycle crunches are extremely effective for targeting the obliques and entire core through rotation.',
  ),
  'bicycle_crunches': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques and abs
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
    },
    description: 'HOW TO: Lie on your back with hands behind your head (not pulling your neck) and legs extended. Lift your shoulders off the ground. Bring one knee toward your chest while rotating your torso to bring the opposite elbow toward that knee. Simultaneously extend the other leg out straight, hovering above the floor. Switch sides in a continuous pedaling motion. Keep your core engaged and avoid pulling on your neck. Bicycle crunches are extremely effective for targeting the obliques and entire core through rotation.',
  ),
  'flutter_kick': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Lie flat on your back with legs extended and hands under your glutes for support. Press your lower back into the floor. Lift both legs slightly off the ground (6-12 inches). Alternately kick your legs up and down in small, rapid movements, keeping legs straight. Keep your core engaged throughout. Maintain steady breathing. Flutter kicks target the lower abs and hip flexors with sustained tension and cardiovascular endurance.',
  ),
  'flutter_kicks': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Lie flat on your back with legs extended and hands under your glutes for support. Press your lower back into the floor. Lift both legs slightly off the ground (6-12 inches). Alternately kick your legs up and down in small, rapid movements, keeping legs straight. Keep your core engaged throughout. Maintain steady breathing. Flutter kicks target the lower abs and hip flexors with sustained tension and cardiovascular endurance.',
  ),
  'scissor_kick': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'adductors': 0.6,
      'abductors': 0.6,
    },
    description: 'HOW TO: Lie flat on your back with legs extended and hands under your glutes. Press your lower back to the floor. Lift both legs slightly off the ground. Spread your legs apart (abduct), then cross them over each other in a scissor motion. Alternate which leg crosses on top. Keep legs straight and core engaged throughout. Scissor kicks work the lower abs, hip flexors, and inner/outer thighs through dynamic leg movement.',
  ),
  'scissor_kicks': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Lower abs
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'adductors': 0.6,
      'abductors': 0.6,
    },
    description: 'HOW TO: Lie flat on your back with legs extended and hands under your glutes. Press your lower back to the floor. Lift both legs slightly off the ground. Spread your legs apart (abduct), then cross them over each other in a scissor motion. Alternate which leg crosses on top. Keep legs straight and core engaged throughout. Scissor kicks work the lower abs, hip flexors, and inner/outer thighs through dynamic leg movement.',
  ),
  'dead_bug': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back with arms extended straight up toward the ceiling and knees bent at 90 degrees with shins parallel to the floor. Press your lower back into the floor. Slowly extend your right arm overhead while simultaneously straightening your left leg, lowering both toward the floor. Keep your lower back pressed down. Return to the starting position and repeat with the opposite arm and leg. Continue alternating. Dead bugs train anti-extension core stability and coordination.',
  ),
  'dead_bugs': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back with arms extended straight up toward the ceiling and knees bent at 90 degrees with shins parallel to the floor. Press your lower back into the floor. Slowly extend your right arm overhead while simultaneously straightening your left leg, lowering both toward the floor. Keep your lower back pressed down. Return to the starting position and repeat with the opposite arm and leg. Continue alternating. Dead bugs train anti-extension core stability and coordination.',
  ),
  'butt_kick': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand tall with feet hip-width apart. Jog in place while kicking your heels up toward your glutes with each step. Aim to touch your glutes with your heels. Stay on the balls of your feet. Pump your arms naturally. Keep your core engaged and posture upright. Butt kicks warm up the hamstrings, improve running mechanics, and increase heart rate.',
  ),
  'butt_kicks': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand tall with feet hip-width apart. Jog in place while kicking your heels up toward your glutes with each step. Aim to touch your glutes with your heels. Stay on the balls of your feet. Pump your arms naturally. Keep your core engaged and posture upright. Butt kicks warm up the hamstrings, improve running mechanics, and increase heart rate.',
  ),
  'butt_kick_sprint': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'calves': 0.5,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand tall. Explosively sprint in place while aggressively kicking your heels up to your glutes with maximum speed and height. Move as fast as possible. Pump your arms powerfully. Stay on the balls of your feet. Maintain upright posture with engaged core. Butt kick sprints combine hamstring activation with high-intensity cardio for explosive power development.',
  ),
  'plank': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'quads': 0.6,
    },
    description: 'HOW TO: Start in a forearm plank position with elbows directly under shoulders and forearms flat on the floor. Extend your legs straight back with toes on the ground. Your body should form a straight line from head to heels. Engage your core, squeeze your glutes, and keep your hips level. Hold this position. Do not let your hips sag or pike up. Keep your neck neutral by looking at the floor. Planks build incredible core endurance and full-body stability.',
  ),
  'planks': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'quads': 0.6,
    },
    description: 'HOW TO: Start in a forearm plank position with elbows directly under shoulders and forearms flat on the floor. Extend your legs straight back with toes on the ground. Your body should form a straight line from head to heels. Engage your core, squeeze your glutes, and keep your hips level. Hold this position. Do not let your hips sag or pike up. Keep your neck neutral by looking at the floor. Planks build incredible core endurance and full-body stability.',
  ),
  'plank_hold': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'quads': 0.6,
    },
    description: 'HOW TO: Start in a forearm plank position with elbows directly under shoulders and forearms flat on the floor. Extend your legs straight back with toes on the ground. Your body should form a straight line from head to heels. Engage your core, squeeze your glutes, and keep your hips level. Hold this position for the prescribed time. Do not let your hips sag or pike up. Keep your neck neutral by looking at the floor. Plank holds build core endurance and anti-extension strength.',
  ),
  'forearm_plank': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'quads': 0.6,
    },
    description: 'HOW TO: Position yourself face down with elbows directly under shoulders and forearms flat on the floor. Extend your legs straight back with toes on the ground. Your body should form a straight line from head to heels. Engage your core, squeeze your glutes, and keep your hips level. Hold this position. Do not let your hips sag or pike up. Keep your neck neutral by looking at the floor. Forearm planks are slightly more challenging than high planks due to reduced leverage.',
  ),
  'high_plank': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'chest': 0.5,
      'glutes': 0.5,
      'quads': 0.6,
    },
    description: 'HOW TO: Start in a push-up position with hands directly under shoulders, arms fully extended. Your body should form a straight line from head to heels. Engage your core, squeeze your glutes, and keep your hips level. Hold this position. Do not let your hips sag or pike up. Keep your neck neutral. High planks are slightly easier than forearm planks but still build tremendous core and shoulder stability.',
  ),
  'side_plank': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'abductors': 0.6,
    },
    description: 'HOW TO: Lie on your side with elbow directly under your shoulder and forearm perpendicular to your body. Stack your feet or place the top foot in front for more stability. Lift your hips off the ground, creating a straight line from head to feet. Keep your core engaged and hips stacked. Hold this position without letting your hips sag. Side planks target the obliques and lateral core stabilizers, essential for anti-lateral flexion strength.',
  ),
  'side_planks': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'abductors': 0.6,
    },
    description: 'HOW TO: Lie on your side with elbow directly under your shoulder and forearm perpendicular to your body. Stack your feet or place the top foot in front for more stability. Lift your hips off the ground, creating a straight line from head to feet. Keep your core engaged and hips stacked. Hold this position without letting your hips sag. Side planks target the obliques and lateral core stabilizers, essential for anti-lateral flexion strength.',
  ),
  'side_plank_left': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Left obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'abductors': 0.6,
    },
    description: 'HOW TO: Lie on your left side with left elbow directly under your shoulder. Stack your feet or stagger them. Lift your hips off the ground, creating a straight line from head to feet. Keep your core engaged and hips stacked. Hold this position without letting your hips sag. Your right arm can rest on your side or reach toward the ceiling. Left side planks specifically target the left obliques and left-side core stabilizers.',
  ),
  'side_plank_right': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Right obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'abductors': 0.6,
    },
    description: 'HOW TO: Lie on your right side with right elbow directly under your shoulder. Stack your feet or stagger them. Lift your hips off the ground, creating a straight line from head to feet. Keep your core engaged and hips stacked. Hold this position without letting your hips sag. Your left arm can rest on your side or reach toward the ceiling. Right side planks specifically target the right obliques and right-side core stabilizers.',
  ),
  'plank_jack': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'abductors': 0.5,
      'adductors': 0.5,
    },
    description: 'HOW TO: Start in a high plank position with hands under shoulders and feet together. Keeping your core tight and hips level, jump both feet out wide apart, then jump them back together. Continue this jumping jack motion with your legs while maintaining a solid plank position. Do not let your hips bounce or sag. Plank jacks combine core stability with cardio and hip abductor/adductor work.',
  ),
  'plank_jacks': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.5,
      'abductors': 0.5,
      'adductors': 0.5,
    },
    description: 'HOW TO: Start in a high plank position with hands under shoulders and feet together. Keeping your core tight and hips level, jump both feet out wide apart, then jump them back together. Continue this jumping jack motion with your legs while maintaining a solid plank position. Do not let your hips bounce or sag. Plank jacks combine core stability with cardio and hip abductor/adductor work.',
  ),
  'plank_tap': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'chest': 0.5,
      'glutes': 0.5,
    },
    description: 'HOW TO: Start in a high plank position. Keeping your core engaged and hips square to the floor, lift one hand and tap your opposite shoulder. Place the hand back down and repeat with the other hand. Continue alternating. Resist rotation by keeping your hips level throughout. Plank taps challenge anti-rotation core strength and shoulder stability.',
  ),
  'plank_walk_out': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'hamstrings': 0.5,
      'chest': 0.6,
    },
    description: 'HOW TO: Stand tall with feet hip-width apart. Hinge at the hips and place your hands on the floor in front of you. Walk your hands forward into a high plank position, keeping your core engaged and legs as straight as possible. Hold the plank briefly. Walk your hands back toward your feet, then stand up. Plank walk-outs combine hamstring flexibility with core and shoulder strength in a dynamic movement.',
  ),
  'bird_dog': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'hamstrings': 0.6,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. Keep your back flat and core engaged. Simultaneously extend your right arm straight forward and left leg straight back, forming a straight line from fingertips to toes. Hold briefly while maintaining balance and keeping hips level. Return to the starting position and repeat with opposite limbs. Continue alternating. Bird dogs develop core stability, balance, and coordination while strengthening the lower back.',
  ),
  'hollow_body_hold': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
      'quads': 0.6,
    },
    description: 'HOW TO: Lie on your back with arms extended overhead. Press your lower back firmly into the floor by engaging your core. Lift your shoulders and legs off the ground simultaneously, creating a "hollow" or "banana" body shape. Keep your arms and legs straight. Hold this position while maintaining lower back contact with the floor. The hollow body hold is a gymnastics staple that builds extreme core strength and body tension.',
  ),
'clamshells': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,        // Glute medius specifically
      'abductors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on your side with knees bent at 45 degrees and feet together. Rest your head on your lower arm. Keep your feet together and engage your core. Lift your top knee as high as possible while keeping your feet touching, opening your legs like a clamshell. Squeeze your glutes at the top. Lower with control. Complete all reps on one side before switching. Clamshells isolate the glute medius, essential for hip stability and preventing knee valgus.',
  ),
  // '90_90_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'glutes': 0.0,
  //     'hip_flexors': 0.0,
  //   },
  //   secondaryMuscles: {},
  //   description: 'HOW TO: Sit on the floor with both knees bent at 90 degrees. Your front shin should be parallel to your body, and your back leg should extend to the side with the knee bent. Sit tall with chest up. Lean forward over your front leg to deepen the hip stretch. Hold this position. To switch sides, rotate your legs to the opposite 90-90 position. This stretch targets hip internal and external rotation, improving hip mobility and relieving tightness.',
  // ),
  // 'butterfly_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'adductors': 0.0,     // Inner thighs
  //     'hip_flexors': 0.0,
  //   },
  //   secondaryMuscles: {},
  //   description: 'HOW TO: Sit on the floor with your knees bent and the soles of your feet pressed together, pulling them close to your groin. Hold your feet with your hands. Sit tall with a straight back. Gently press your knees down toward the floor using your elbows. Hold this position while breathing deeply. For a deeper stretch, lean forward from your hips while keeping your back straight. Butterfly stretch improves hip mobility and stretches the inner thighs.',
  // ),
  // 'cat_cow': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'lower_back': 0.0,
  //     'core': 0.0,
  //   },
  //   secondaryMuscles: {},
  //   description: 'HOW TO: Start on all fours with hands under shoulders and knees under hips. For the "cow" position: Inhale, drop your belly toward the floor, lift your chest and tailbone up, and look slightly upward. For the "cat" position: Exhale, round your spine toward the ceiling, tuck your tailbone, and drop your head. Flow smoothly between these two positions with your breath. Cat-cow improves spine mobility, relieves back tension, and warms up the core.',
  // ),
  // 'chest_doorway_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'chest': 0.0,
  //     'front_delts': 0.0,
  //   },
  //   secondaryMuscles: {},
  //   description: 'HOW TO: Stand in a doorway or next to a wall. Place your forearm against the doorframe with your elbow at shoulder height and bent at 90 degrees. Step forward with the leg on the same side until you feel a stretch across your chest and front shoulder. Keep your core engaged and chest up. Hold this position. You can adjust the angle of your arm higher or lower to target different parts of the chest. This stretch counteracts rounded shoulders and tight chest muscles.',
  // ),
  // 'frog_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'adductors': 0.0,     // Inner thighs
  //     'hip_flexors': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'glutes': 0.6,
  //   },
  //   description: 'HOW TO: Start on all fours. Spread your knees as wide as comfortable while keeping your ankles in line with your knees. Turn your feet out so the inner edges are flat on the floor. Lower down onto your forearms. Gently push your hips back toward your heels and let your torso sink toward the floor. Hold this position while breathing deeply. The frog stretch is one of the most effective stretches for hip adductor flexibility and hip mobility.',
  // ),
  // 'hamstring_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'hamstrings': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'lower_back': 0.6,
  //     'calves': 0.6,
  //   },
  //   description: 'HOW TO: Sit on the floor with one leg extended straight and the other bent with foot against your inner thigh. Keep your back straight and chest up. Hinge at your hips and reach toward your toes on the extended leg. Keep the extended leg straight but not locked. Hold when you feel a stretch in your hamstring. Avoid rounding your back. Breathe deeply and relax into the stretch. Complete one side before switching. Hamstring stretches improve posterior chain flexibility and reduce lower back strain.',
  // ),
  // 'happy_baby': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'hip_flexors': 0.0,
  //     'glutes': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'lower_back': 0.6,
  //     'adductors': 0.6,
  //   },
  //   description: 'HOW TO: Lie on your back. Bring your knees toward your chest, then spread them apart wider than your torso. Grab the outside edges of your feet with your hands, bringing your ankles directly above your knees (shins perpendicular to floor). Gently pull your feet down toward the floor while pressing your knees down with your elbows. Keep your lower back on the floor. Rock gently side to side if desired. Happy baby pose stretches the hips, groin, and lower back while calming the nervous system.',
  // ),
  // 'hip_flexor_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'hip_flexors': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'quads': 0.6,
  //   },
  //   description: 'HOW TO: Kneel on one knee with the other foot flat in front of you, forming a 90-degree angle with both knees (lunge position). Keep your torso upright with chest up. Engage your core and squeeze the glute of your back leg. Shift your hips forward until you feel a stretch in the front of your back hip. For a deeper stretch, raise the arm on the same side as your back leg overhead and lean slightly to the opposite side. Hold and breathe. Switch sides. Hip flexor stretches combat the effects of prolonged sitting.',
  // ),
  // 'pigeon_pose': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'glutes': 0.0,
  //     'hip_flexors': 0.0,
  //   },
  //   secondaryMuscles: {},
  //   description: 'HOW TO: Start in a plank or downward dog position. Bring your right knee forward and place it behind your right wrist, with your shin angled toward your left hip. Extend your left leg straight back with the top of your foot on the floor. Square your hips to face forward. Sit up tall or fold forward over your front leg for a deeper stretch. Hold while breathing deeply. Switch sides. Pigeon pose deeply stretches the hip rotators and flexors, essential for hip mobility and relieving sciatic tension.',
  // ),
  // 'quad_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'quads': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'hip_flexors': 0.6,
  //   },
  //   description: 'HOW TO: Stand on one leg (use a wall for balance if needed). Bend your other knee and grab your ankle or foot behind you with the same-side hand. Pull your heel toward your glute while keeping your knees together. Keep your torso upright and core engaged. Squeeze the glute of the stretching leg. For a deeper stretch, gently push your hips forward. Hold and breathe. Switch sides. Quad stretches improve quadriceps flexibility and help prevent knee pain.',
  // ),
  // 'superman_raises': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'lower_back': 0.0,
  //     'glutes': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'hamstrings': 0.5,
  //     'rear_delts': 0.5,
  //     'traps': 0.6,
  //   },
  //   description: 'HOW TO: Lie face down with arms extended overhead and legs straight. Engage your core and glutes. Simultaneously lift your arms, chest, and legs off the floor as high as possible, creating a "U" shape with your body. Hold briefly at the top while squeezing your glutes and lower back. Lower back down with control. Repeat for reps. Superman raises strengthen the entire posterior chain, particularly the lower back and glutes.',
  // ),
  // 'worlds_greatest_stretch': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'hip_flexors': 0.0,
  //     'hamstrings': 0.0,
  //     'glutes': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'thoracic_spine': 0.5,
  //     'adductors': 0.6,
  //   },
  //   description: 'HOW TO: Start in a lunge position with right foot forward, hands on the floor inside your front foot. Drop your back knee down. Reach your right arm overhead and rotate your torso to the right, opening your chest. Return your hand down. Then sit back and straighten your front leg, folding over it for a hamstring stretch. Return to the lunge. Repeat the sequence on one side, then switch legs. This dynamic stretch mobilizes hips, hamstrings, thoracic spine, and ankles simultaneously.',
  // ),
  // 'childs_pose': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'lower_back': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'lats': 0.6,
  //     'glutes': 0.6,
  //   },
  //   description: 'HOW TO: Kneel on the floor with big toes touching and knees spread apart. Sit back on your heels. Fold forward, extending your arms straight in front of you on the floor. Rest your forehead on the ground. Relax your entire body, letting your chest sink toward the floor. Breathe deeply into your back. Hold this position. Child\'s pose is a restorative stretch that relieves tension in the lower back, shoulders, and hips while calming the mind.',
  // ),
  // 'wall_sit': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'quads': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'glutes': 0.5,
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Stand with your back against a wall. Walk your feet out about 2 feet from the wall. Slide down the wall until your thighs are parallel to the floor and knees are at 90 degrees. Your knees should be directly above your ankles. Keep your back flat against the wall, core engaged, and arms at your sides or crossed over your chest. Hold this position. Wall sits build incredible quadriceps endurance and mental toughness.',
  // ),
  // 'wall_sits': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'quads': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'glutes': 0.5,
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Stand with your back against a wall. Walk your feet out about 2 feet from the wall. Slide down the wall until your thighs are parallel to the floor and knees are at 90 degrees. Your knees should be directly above your ankles. Keep your back flat against the wall, core engaged, and arms at your sides or crossed over your chest. Hold this position. Wall sits build incredible quadriceps endurance and mental toughness.',
  // ),
  // 'wall_squat': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'quads': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'glutes': 0.5,
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Stand with your back against a wall. Walk your feet out about 2 feet from the wall. Slide down the wall until your thighs are parallel to the floor and knees are at 90 degrees. Your knees should be directly above your ankles. Keep your back flat against the wall, core engaged, and arms at your sides or crossed over your chest. Hold this position. Wall squats (wall sits) build quadriceps endurance through isometric contraction.',
  // ),
  // 'dead_hang': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'forearms': 0.0,
  //     'lats': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'traps': 0.6,
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Grab a pull-up bar with an overhand grip, hands shoulder-width apart. Allow your body to hang completely with arms fully extended. Relax your shoulders and let them elevate naturally. Keep your legs straight or slightly bent. Engage your core to prevent excessive swinging. Hold this position for time. Dead hangs decompress the spine, build tremendous grip strength, and improve shoulder mobility and health.',
  // ),
  // 'active_hang': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'lats': 0.0,
  //     'forearms': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'traps': 0.5,
  //     'core': 0.5,
  //     'rear_delts': 0.6,
  //   },
  //   description: 'HOW TO: Grab a pull-up bar with an overhand grip, hands shoulder-width apart. Hang with arms fully extended. Actively engage your lats and pull your shoulder blades down and together (scapular depression and retraction), lifting your body slightly. Your arms remain straight, but you create tension throughout your back. Hold this engaged position. Active hangs build scapular strength and stability essential for pull-ups and overhead movements.',
  // ),
  // 'hang': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'forearms': 0.0,
  //     'lats': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'traps': 0.6,
  //     'core': 0.6,
  //   },
  //   description: 'HOW TO: Grab a pull-up bar with an overhand grip, hands shoulder-width apart. Allow your body to hang with arms fully extended. You can either dead hang (relaxed shoulders) or active hang (engaged lats and shoulder blades pulled down). Keep your core engaged. Hold this position for time. Hanging builds grip strength, decompresses the spine, and improves shoulder health.',
  // ),
  // 'l_sit': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //     'hip_flexors': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'quads': 0.5,
  //     'triceps': 0.5,
  //     'front_delts': 0.5,
  //   },
  //   description: 'HOW TO: Sit on the floor with legs extended straight in front of you. Place your hands on the floor beside your hips, fingers pointing forward. Press down through your hands, engage your core, and lift your entire body off the floor. Keep your legs straight and parallel to the floor, forming an "L" shape. Hold this position. L-sits are an advanced gymnastics skill that builds extreme core, hip flexor, and shoulder strength.',
  // ),
  // 'l_sits': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'core': 0.0,
  //     'hip_flexors': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'quads': 0.5,
  //     'triceps': 0.5,
  //     'front_delts': 0.5,
  //   },
  //   description: 'HOW TO: Sit on the floor with legs extended straight in front of you. Place your hands on the floor beside your hips, fingers pointing forward. Press down through your hands, engage your core, and lift your entire body off the floor. Keep your legs straight and parallel to the floor, forming an "L" shape. Hold this position. L-sits are an advanced gymnastics skill that builds extreme core, hip flexor, and shoulder strength.',
  // ),
  // 'superman': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'lower_back': 0.0,
  //     'glutes': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'hamstrings': 0.5,
  //     'rear_delts': 0.5,
  //     'traps': 0.6,
  //   },
  //   description: 'HOW TO: Lie face down with arms extended overhead and legs straight. Engage your core and glutes. Simultaneously lift your arms, chest, and legs off the floor as high as possible, creating a "U" shape with your body. Squeeze your glutes and lower back at the top. Hold briefly, then lower back down with control. Repeat for reps. Superman exercises strengthen the entire posterior chain, improve posture, and protect the lower back.',
  // ),
  // 'supermans': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'lower_back': 0.0,
  //     'glutes': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'hamstrings': 0.5,
  //     'rear_delts': 0.5,
  //     'traps': 0.6,
  //   },
  //   description: 'HOW TO: Lie face down with arms extended overhead and legs straight. Engage your core and glutes. Simultaneously lift your arms, chest, and legs off the floor as high as possible, creating a "U" shape with your body. Squeeze your glutes and lower back at the top. Hold briefly, then lower back down with control. Repeat for reps. Superman exercises strengthen the entire posterior chain, improve posture, and protect the lower back.',
  // ),
  // 'superman_hold': ExerciseMuscleData(
  //   primaryMuscles: {
  //     'lower_back': 0.0,
  //     'glutes': 0.0,
  //   },
  //   secondaryMuscles: {
  //     'hamstrings': 0.5,
  //     'rear_delts': 0.5,
  //     'traps': 0.6,
  //   },
  //   description: 'HOW TO: Lie face down with arms extended overhead and legs straight. Engage your core and glutes. Simultaneously lift your arms, chest, and legs off the floor as high as possible, creating a "U" shape with your body. Squeeze your glutes and lower back maximally. Hold this elevated position for the prescribed time. Keep breathing steadily. Lower back down with control. Superman holds build isometric posterior chain strength and endurance.',
  // ),
  'russian_twist': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
    },
    description: 'HOW TO: Sit on the floor with knees bent and feet flat. Lean back slightly to engage your core, lifting your feet off the ground if possible for added difficulty. Hold your hands together at your chest or hold a weight. Rotate your torso to the right, bringing your hands toward the floor beside your hip. Rotate back through center and twist to the left. Continue alternating in a controlled motion. Keep your core engaged throughout. Russian twists build rotational core strength and oblique definition.',
  ),
  'russian_twists': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
    },
    description: 'HOW TO: Sit on the floor with knees bent and feet flat. Lean back slightly to engage your core, lifting your feet off the ground if possible for added difficulty. Hold your hands together at your chest or hold a weight. Rotate your torso to the right, bringing your hands toward the floor beside your hip. Rotate back through center and twist to the left. Continue alternating in a controlled motion. Keep your core engaged throughout. Russian twists build rotational core strength and oblique definition.',
  ),
  'russian_twist_weighted': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'hip_flexors': 0.5,
    },
    description: 'HOW TO: Sit on the floor with knees bent and feet flat (or elevated). Lean back slightly to engage your core. Hold a dumbbell, medicine ball, or weight plate with both hands at your chest. Rotate your torso to the right, bringing the weight toward the floor beside your right hip. Rotate back through center and twist to the left side. Continue alternating with control. The added weight increases resistance and builds more powerful rotational strength in the obliques.',
  ),
  'wood_chop': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart holding a dumbbell, medicine ball, or cable attachment with both hands. Start with the weight at one hip. Rotate and lift the weight diagonally across your body in a chopping motion, ending above the opposite shoulder. Pivot on your back foot and rotate your torso. Control the weight back down to the starting position. Complete all reps on one side before switching. Wood chops develop rotational power and functional core strength.',
  ),
  'wood_chops': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart holding a dumbbell, medicine ball, or cable attachment with both hands. Start with the weight at one hip. Rotate and lift the weight diagonally across your body in a chopping motion, ending above the opposite shoulder. Pivot on your back foot and rotate your torso. Control the weight back down to the starting position. Complete all reps on one side before switching. Wood chops develop rotational power and functional core strength.',
  ),
  'cable_wood_chop': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand sideways to a cable machine with the pulley set high. Grab the handle with both hands, arms extended. Stand with feet shoulder-width apart. Pull the handle down and across your body in a diagonal chopping motion, rotating your torso and pivoting on your back foot. The motion should end near your opposite hip. Control the cable back to the starting position. Complete all reps before switching sides. Cable wood chops provide constant tension for explosive rotational core development.',
  ),
  'medicine_ball_woodchop': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart holding a medicine ball with both hands. Start with the ball at one hip. Explosively rotate and lift the ball diagonally across your body in a chopping motion, ending above the opposite shoulder. Pivot on your back foot, engage your core, and use your entire body. Control the ball back down. Complete all reps on one side before switching. Medicine ball wood chops build explosive rotational power for sports.',
  ),
  'dumbbell_woodchop': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart holding a dumbbell with both hands. Start with the dumbbell at one hip. Rotate and lift the dumbbell diagonally across your body in a chopping motion, ending above the opposite shoulder. Pivot on your back foot and rotate your torso fully. Control the dumbbell back down to the starting position. Complete all reps on one side before switching. Dumbbell wood chops develop rotational strength and core power.',
  ),
  'woodchop': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart holding a weight (dumbbell, medicine ball, or cable) with both hands. Start with the weight at one hip. Rotate and lift the weight diagonally across your body in a chopping motion, ending above the opposite shoulder. Pivot on your back foot and rotate your torso. Control the weight back down to the starting position. Complete all reps on one side before switching. Wood chops develop rotational power and functional core strength.',
  ),
  'woodchoppers': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques primarily
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'glutes': 0.6,
      'quads': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart holding a weight (dumbbell, medicine ball, or cable) with both hands. Start with the weight at one hip. Rotate and lift the weight diagonally across your body in a chopping motion, ending above the opposite shoulder. Pivot on your back foot and rotate your torso. Control the weight back down to the starting position. Complete all reps on one side before switching. Wood choppers develop rotational power and functional core strength.',
  ),
  'windmill': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques
      'front_delts': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Stand with feet wider than shoulder-width. Hold a kettlebell or dumbbell overhead in one hand with arm fully extended. Keep your eyes on the weight. Shift your hips to the side of the weighted arm. Lower your opposite hand toward the floor by hinging at the hip and bending slightly sideways, keeping the weighted arm vertical. Go as low as mobility allows. Return to standing. Complete all reps on one side before switching. Windmills build shoulder stability, oblique strength, and hip mobility.',
  ),
  'windmills': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques
      'front_delts': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Stand with feet wider than shoulder-width. Hold a kettlebell or dumbbell overhead in one hand with arm fully extended. Keep your eyes on the weight. Shift your hips to the side of the weighted arm. Lower your opposite hand toward the floor by hinging at the hip and bending slightly sideways, keeping the weighted arm vertical. Go as low as mobility allows. Return to standing. Complete all reps on one side before switching. Windmills build shoulder stability, oblique strength, and hip mobility.',
  ),
  'pallof_press': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Anti-rotation
    },
    secondaryMuscles: {
      'front_delts': 0.6,
      'chest': 0.6,
    },
    description: 'HOW TO: Stand sideways to a cable machine with the handle at chest height. Hold the handle with both hands at your chest, feet shoulder-width apart. Step away from the machine to create tension. Engage your core to resist rotation. Press the handle straight out in front of you, fully extending your arms. Hold briefly, resisting the cable trying to pull you toward the machine. Pull back to your chest. Complete all reps before switching sides. Pallof presses build elite anti-rotation core strength.',
  ),
  'pallof_press_kneeling': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Anti-rotation
    },
    secondaryMuscles: {
      'front_delts': 0.6,
      'chest': 0.6,
      'glutes': 0.6,
    },
    description: 'HOW TO: Kneel sideways to a cable machine with the handle at chest height. Hold the handle with both hands at your chest. Position yourself so there is tension on the cable. Engage your core and squeeze your glutes. Press the handle straight out, fully extending your arms while resisting rotation. Hold briefly. Pull back to your chest. Complete all reps before switching sides. The kneeling position increases core demand by reducing your base of support.',
  ),
  'pallof_press_standing': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Anti-rotation
    },
    secondaryMuscles: {
      'front_delts': 0.6,
      'chest': 0.6,
    },
    description: 'HOW TO: Stand sideways to a cable machine with the handle at chest height. Hold the handle with both hands at your chest, feet shoulder-width apart. Step away from the machine to create tension. Engage your core to resist rotation. Press the handle straight out in front of you, fully extending your arms. Hold briefly, resisting the cable trying to pull you toward the machine. Pull back to your chest. Complete all reps before switching sides. Standing Pallof presses build anti-rotation core strength for injury prevention.',
  ),
  'pallof_press_split_stance': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Anti-rotation
    },
    secondaryMuscles: {
      'front_delts': 0.6,
      'chest': 0.6,
      'glutes': 0.6,
    },
    description: 'HOW TO: Stand in a split stance (one foot forward, one back) sideways to a cable machine with the handle at chest height. Hold the handle with both hands at your chest. Create tension on the cable. Engage your core. Press the handle straight out, fully extending your arms while resisting rotation. Hold briefly. Pull back to your chest. Complete all reps before switching sides and stances. Split stance increases the challenge by narrowing your base of support.',
  ),
  'landmine_rotation': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'chest': 0.5,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart facing a landmine (barbell anchored at one end). Hold the top of the barbell with both hands at chest height, arms extended. Engage your core. Rotate the barbell from one side to the other in an arc motion, pivoting through your torso and feet. Keep your arms relatively straight. Control the movement throughout. Landmine rotations develop explosive rotational power for the obliques and total core.',
  ),
  'seated_twist': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on the floor or bench with knees bent and feet flat. Keep your torso upright. Hold a weight plate, medicine ball, or broomstick across your chest. Engage your core. Rotate your torso to the right as far as comfortable, then rotate to the left. Continue alternating sides in a controlled motion. Focus on rotating through your spine, not just moving your arms. Seated twists improve spinal rotation mobility and oblique strength.',
  ),
  'oblique_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor. Place one hand behind your head and the other hand on the floor for support. Engage your core. Crunch up and rotate, bringing your elbow toward the opposite knee. Focus on lifting with your abs and rotating through your torso. Lower back down with control. Complete all reps on one side before switching. Oblique crunches specifically target the obliques for improved definition and rotational strength.',
  ),
  'oblique_crunches': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,          // Obliques
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor. Place one hand behind your head and the other hand on the floor for support. Engage your core. Crunch up and rotate, bringing your elbow toward the opposite knee. Focus on lifting with your abs and rotating through your torso. Lower back down with control. Complete all reps on one side before switching. Oblique crunches specifically target the obliques for improved definition and rotational strength.',
  ),
  'calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand with the balls of your feet on an elevated surface (step, block, or platform) with heels hanging off the edge. Hold onto something for balance if needed. Lower your heels below the level of the platform to stretch your calves. Push up onto your toes as high as possible by contracting your calves. Squeeze at the top. Lower back down with control. Calf raises build the gastrocnemius and soleus muscles for lower leg strength, power, and definition.',
  ),
  'calf_raises': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand with the balls of your feet on an elevated surface (step, block, or platform) with heels hanging off the edge. Hold onto something for balance if needed. Lower your heels below the level of the platform to stretch your calves. Push up onto your toes as high as possible by contracting your calves. Squeeze at the top. Lower back down with control. Calf raises build the gastrocnemius and soleus muscles for lower leg strength, power, and definition.',
  ),
  'standing_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand with the balls of your feet on an elevated surface (step, block, or platform) with heels hanging off the edge. Hold dumbbells at your sides or use a standing calf raise machine. Lower your heels below the level of the platform to stretch your calves fully. Push up onto your toes as high as possible by contracting your calves. Squeeze maximally at the top. Lower with control. Standing calf raises emphasize the gastrocnemius (upper calf) and build explosive lower leg power.',
  ),
  'standing_calf_raises': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand with the balls of your feet on an elevated surface (step, block, or platform) with heels hanging off the edge. Hold dumbbells at your sides or use a standing calf raise machine. Lower your heels below the level of the platform to stretch your calves fully. Push up onto your toes as high as possible by contracting your calves. Squeeze maximally at the top. Lower with control. Standing calf raises emphasize the gastrocnemius (upper calf) and build explosive lower leg power.',
  ),
  'seated_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,        // Soleus primarily
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench or use a seated calf raise machine. Place the balls of your feet on an elevated surface with heels hanging off. Place weight across your thighs (dumbbells, barbell, or machine pad). Lower your heels below the level of the platform to stretch your calves. Push up onto your toes as high as possible by contracting your calves. Squeeze at the top. Lower with control. Seated calf raises emphasize the soleus (lower calf) due to the bent knee position.',
  ),
'seated_calf_raises': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,        // Soleus primarily
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench or use a seated calf raise machine. Place the balls of your feet on an elevated surface with heels hanging off. Place weight across your thighs (dumbbells, barbell, or machine pad). Lower your heels below the level of the platform to stretch your calves fully. Push up onto your toes as high as possible by contracting your calves. Squeeze hard at the top. Lower with control. Seated calf raises emphasize the soleus (lower calf muscle) due to the bent knee position, building thickness in the lower calf.',
  ),
  'donkey_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Position yourself in a bent-over position with your hands on a bench or elevated surface, torso parallel to the floor. Have a partner sit on your lower back (traditional method) or use a donkey calf raise machine. Place the balls of your feet on an elevated platform with heels hanging off. Lower your heels below the platform to stretch your calves. Push up onto your toes as high as possible by contracting your calves powerfully. Squeeze at the top. Lower with control. Donkey calf raises allow for maximum calf stretch and contraction, building exceptional calf development.',
  ),
  'single_leg_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand on one leg with the ball of your foot on an elevated surface (step or platform) and heel hanging off. Your other leg can hang relaxed or be crossed behind your working leg. Hold onto something for balance. Lower your heel below the platform to fully stretch your calf. Push up onto your toes as high as possible by contracting your calf. Squeeze maximally at the top. Lower with control. Complete all reps on one leg before switching. Single-leg calf raises address imbalances and build unilateral calf strength and stability.',
  ),
  'jump_rope': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'front_delts': 0.5,
      'forearms': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Hold a jump rope handle in each hand with the rope behind you. Stand with feet together, knees slightly bent. Swing the rope over your head using wrist rotation, not large arm movements. Jump just high enough for the rope to pass under your feet (1-2 inches off ground). Land softly on the balls of your feet with knees slightly bent. Keep your core engaged and stay light on your feet. Maintain a steady rhythm. Jump rope is an exceptional cardio exercise that builds calf endurance, coordination, footwork, and cardiovascular fitness while burning massive calories.',
  ),
};
