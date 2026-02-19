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
  
  // ============================================================================
  // BATCH 1: NEW EXERCISE DESCRIPTIONS (1-50 of 341)
  // ============================================================================
  
  'air_bike_m': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Lie on your back with hands behind your head, elbows wide. Lift your shoulders off the ground and raise your legs so your thighs are perpendicular to the floor. Simultaneously bring your right elbow toward your left knee while extending your right leg straight out. Then switch sides, bringing your left elbow to your right knee while extending your left leg. Continue alternating in a pedaling motion. Keep your core engaged throughout and avoid pulling on your neck. This dynamic movement torches calories while sculpting your entire core.',
  ),
  'barbell_behind_back_finger_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.6,
    },
    description: 'HOW TO: Stand upright holding a barbell behind your back with palms facing away from your body. Let the barbell roll down to your fingertips with arms fully extended. Keep your wrists neutral and elbows locked. Using only your fingers and grip strength, curl the bar back up into your palms by flexing your fingers closed. Hold briefly at the top. Lower back to fingertips with control. This exercise builds exceptional finger and grip strength, crucial for deadlifts and pulling movements.',
  ),
  'barbell_bench_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Position a bench behind you. Hold a barbell across your upper back and shoulders. Stand with feet shoulder-width apart in front of the bench. Lower down by pushing your hips back and bending your knees until you lightly touch the bench with your glutes. Keep your chest up and core braced. Do not sit or relax on the bench. Immediately drive through your heels to stand back up. The bench acts as a depth gauge, ensuring consistent squat depth and building explosive power from the bottom position.',
  ),
  'barbell_bent_arm_pullover': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench with head supported. Hold a barbell above your chest with arms bent at roughly 90 degrees. Keep your elbows at this angle throughout. Lower the barbell back over and behind your head in an arc, feeling a stretch through your lats and chest. Go as far as comfortable without pain. Pull the barbell back up over your chest using your lats and chest. The bent arm position emphasizes the lats more than a straight-arm pullover, building width and thickness in your back.',
  ),
  'barbell_decline_bent_arm_pullover': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'lats': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a decline bench with your feet secured at the top and head lower than your hips. Hold a barbell above your chest with arms bent at 90 degrees. Keeping elbows bent, lower the barbell back in an arc over and behind your head until you feel a deep stretch in your lats and chest. Pull the bar back up over your chest. The decline angle increases the stretch on the lower chest and creates constant tension throughout the movement, building exceptional upper body development.',
  ),
  'barbell_decline_close_grip_to_skull_press': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'front_delts': 0.6,
    },
    description: 'HOW TO: Lie on a decline bench with feet secured. Hold a barbell with a close grip (hands 6-8 inches apart) above your chest. Lower the bar toward your forehead by bending only at the elbows while keeping upper arms stationary. When the bar reaches your forehead, press it back up and forward toward your chest using your triceps. The decline angle increases the stretch on the triceps while the close grip maximizes triceps activation throughout the entire range of motion.',
  ),
  'barbell_decline_pullover': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a decline bench with feet secured and head lower than hips. Hold a barbell above your chest with arms nearly straight, elbows slightly bent. Lower the barbell back in an arc over and behind your head, keeping arms relatively straight. Feel an intense stretch through your lats and chest. Pull the bar back up over your chest using your lats. The decline position intensifies the stretch and increases time under tension, building powerful lats and a thick chest.',
  ),
  'barbell_decline_wide_grip_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Lie on a decline bench with feet secured at the top. Grip the barbell with hands wider than shoulder-width (about 1.5x shoulder width). Unrack the bar and position it above your lower chest. Lower the bar with control to your lower chest, elbows flaring out at about 45 degrees. Press the bar back up powerfully until arms are extended. The wide grip emphasizes outer chest development while the decline angle targets the lower chest fibers for complete pec development.',
  ),
  'barbell_decline_wide_grip_pullover': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'triceps': 0.6,
    },
    description: 'HOW TO: Lie on a decline bench with feet secured. Hold a barbell with a wide grip (wider than shoulder-width) above your chest with arms nearly straight. Lower the bar back in an arc over and behind your head, maintaining the wide grip. Feel a massive stretch across your entire upper back and chest. Pull the bar back up over your chest. The wide grip increases lat activation across a broader range while the decline maximizes the stretch for exceptional upper body expansion.',
  ),
  'barbell_drag_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell with a shoulder-width grip, arms extended. Instead of curling the bar in an arc away from your body, drag the bar up along your torso by pulling your elbows back behind your body. The bar should stay in contact with or very close to your abs and chest as it travels up. Squeeze your biceps hard at the top. Lower with the same dragging motion. This eliminates front delt involvement and creates intense peak contraction in the biceps.',
  ),
  'barbell_full_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Position a barbell across your upper back. Stand with feet shoulder-width apart. Squat down as deep as possible, going well below parallel until your hamstrings touch your calves. Keep your chest up, core tight, and knees tracking over toes. Drive through your heels to stand back up. Full squats require excellent mobility and build incredible leg development, but only go as deep as you can maintain proper form. Ass to grass for maximum gains.',
  ),
  'barbell_high_bar_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position the barbell high on your traps (on top of your shoulders), not on your rear delts. Grip the bar with a narrower grip than low bar squats. Stand with feet shoulder-width apart. Keep your torso more upright than low bar squats. Squat down by bending your knees forward while keeping chest up. Go to at least parallel depth. Drive straight up through your heels. High bar squats emphasize quad development and allow for a more upright torso position, building powerful legs with proper Olympic lifting mechanics.',
  ),
  'barbell_incline_reverse_grip_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Lie on an incline bench set to 30-45 degrees. Grip the barbell with an underhand grip (palms facing your face) at shoulder-width. Unrack the bar and position it above your upper chest. Lower the bar with control to your upper chest, keeping elbows relatively close to your body. Press back up powerfully. The reverse grip shifts emphasis to the upper chest and increases biceps activation while reducing shoulder strain compared to regular incline press.',
  ),
  'barbell_incline_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
      'lower_back': 0.6,
    },
    description: 'HOW TO: Set an incline bench to 45 degrees. Lie face-down on the bench with chest supported and feet on the floor. Hold a barbell with an overhand grip, arms hanging straight down. Pull the bar up toward the underside of the bench by driving your elbows back and squeezing your shoulder blades together. Keep your chest pressed into the bench. Lower with control. The chest support eliminates momentum and lower back strain, allowing you to isolate your back muscles with perfect form.',
  ),
  'barbell_incline_wide_reverse_grip_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Lie on an incline bench set to 30-45 degrees. Grip the barbell with an underhand grip (palms up) wider than shoulder-width. Unrack and position the bar above your upper chest. Lower the bar to your upper chest with control, elbows flaring out slightly. Press back up powerfully. The combination of incline angle, reverse grip, and wide grip creates unique upper chest activation while also engaging the biceps, building complete upper body strength.',
  ),
  'barbell_low_bar_squat': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Position the barbell lower on your back, resting on your rear delts (not on top of your traps). Use a wider grip. Stand with feet shoulder-width apart or slightly wider. Your torso will lean forward more than high bar squats. Push your hips back and squat down to at least parallel. Drive through your heels to stand up. Low bar squats allow for heavier loads and emphasize posterior chain development (glutes, hamstrings, lower back), making it the preferred powerlifting variation.',
  ),
  'barbell_low_bar_squat_with_rack': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'quads': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'lower_back': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Set the safety bars in a squat rack at your desired depth (parallel or slightly below). Position the barbell low on your rear delts. Stand with feet shoulder-width apart. Squat down until the bar lightly touches the safety bars. Pause briefly, then drive back up. The safety bars provide a consistent depth cue and allow you to push harder without fear of getting stuck, building confidence and strength at the bottom position of the squat.',
  ),
  'barbell_lying_back_of_the_head_tricep_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding a barbell with a close to medium grip. Extend your arms straight up, then angle them back slightly so the bar is above your forehead (not straight up from shoulders). Keeping your upper arms stationary and angled back, lower the bar behind and past your head by bending only at the elbows. Feel a deep stretch in your triceps. Extend back to start. This variation maximizes triceps stretch and long head activation for complete arm development.',
  ),
  'barbell_lying_close_grip_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding a barbell with hands 6-8 inches apart. Extend your arms straight up above your chest. Keeping your upper arms perpendicular to the floor and locked in position, lower the bar down toward your forehead or just past your head by bending only at the elbows. Extend back up using only your triceps. Keep your elbows tucked in, not flaring out. The close grip maximizes triceps activation while minimizing shoulder and chest involvement.',
  ),
  'barbell_lying_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench with a barbell held at arm\'s length above your chest. Lock your upper arms in a vertical position. Bend only at your elbows to lower the bar down toward your forehead, keeping upper arms stationary. Your forearms should be the only part moving. Extend back up by contracting your triceps. The key is keeping your upper arms perfectly still - all movement comes from the elbow joint. This isolation builds powerful triceps without shoulder strain.',
  ),
  'barbell_lying_lifting_on_hip': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor. Position a barbell across your hips, holding it in place with both hands. Drive through your heels and squeeze your glutes to lift your hips up toward the ceiling, raising the barbell. Lift until your body forms a straight line from shoulders to knees. Hold the top position, squeezing your glutes hard. Lower with control. This hip thrust variation builds exceptional glute strength and power.',
  ),
  'barbell_olympic_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position the barbell high on your traps with a clean grip (hands at shoulder-width or slightly wider). Stand with feet shoulder-width apart, toes slightly out. Keep your torso extremely upright throughout. Squat down as deep as possible (ass to grass) by driving your knees forward while keeping chest up. Your elbows should point forward. Drive straight up explosively. Olympic squats build the leg strength and mobility required for Olympic weightlifting while maximizing quad development.',
  ),
  'barbell_one_leg_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.5,
    },
    description: 'HOW TO: Hold a barbell across your upper back. Stand on one leg with the other leg extended straight out in front (not touching the ground). Squat down on your working leg as far as possible while keeping your other leg extended forward. Your extended leg helps with balance. Keep your chest up and core tight. Drive through your working heel to stand back up. Complete all reps on one side, then switch. This advanced unilateral movement builds exceptional single-leg strength and balance.',
  ),
  'barbell_quarter_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Position a barbell across your upper back. Stand with feet shoulder-width apart. Squat down only about one-quarter of the way (roughly 45 degrees of knee bend), not reaching parallel. Drive back up explosively. Quarter squats allow you to use significantly more weight than full squats and build explosive power, athletic performance, and tendon strength. They\'re excellent for powerlifting lockout strength and sports performance, though they should complement, not replace, full squats.',
  ),
  'barbell_rear_delt_row': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'lats': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Bend forward at the hips until your torso is roughly parallel to the floor. Hold a barbell with an overhand grip at shoulder-width. Let the bar hang at arm\'s length. Pull the bar up toward your upper chest/lower neck by driving your elbows up and out to the sides at roughly 90 degrees from your body. Focus on squeezing your rear delts and upper back at the top. Lower with control. This row variation specifically targets rear delts for complete shoulder development.',
  ),
  'barbell_rear_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Hold a barbell across your upper back. Stand with feet together. Step one leg backward, landing on the ball of your foot. Lower your back knee toward the floor until your front thigh is parallel to the ground. Your front knee should stay behind your toes. Push through your front heel to return to standing, bringing your back leg forward. Alternate legs. Rear lunges are easier on the knees than forward lunges while building powerful legs and glutes.',
  ),
  'barbell_reverse_grip_incline_bench_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Lie face-down on an incline bench set to 45 degrees with chest supported. Hold a barbell with an underhand grip (palms facing up), arms hanging straight down. Pull the bar up toward the underside of the bench by driving your elbows back. Focus on squeezing your lats and upper back. The reverse grip increases biceps involvement while the incline provides chest support for perfect isolation. Lower with control. This variation builds thick lats and strong biceps simultaneously.',
  ),
  'barbell_reverse_grip_skullcrusher': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
      'chest': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding a barbell with an underhand grip (palms facing toward your head). Extend your arms straight up above your chest. Keeping your upper arms stationary, lower the bar toward your forehead by bending at the elbows. The reverse grip will feel awkward at first. Extend back up using your triceps. The underhand grip changes the angle of stress on the triceps and increases forearm activation, providing a unique stimulus for arm growth.',
  ),
  'barbell_seated_behind_head_military_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support. Position a barbell behind your head resting on your upper traps. Grip slightly wider than shoulder-width. Press the bar straight up overhead until arms are fully extended. Lower with control back to the starting position behind your head. Keep your core tight and avoid excessive arching. This variation requires good shoulder mobility and provides a deeper stretch, building complete shoulder development. Use with caution if you have shoulder issues.',
  ),
  'barbell_seated_close_grip_behind_neck_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support. Hold a barbell overhead with a close grip (hands 6-8 inches apart), arms fully extended. Keeping your upper arms vertical and stationary, lower the bar behind your head by bending only at the elbows. Go until you feel a deep stretch in your triceps. Press back up to full extension. Keep your elbows pointing up, not flaring out. This seated position provides stability while maximizing triceps stretch for exceptional arm development.',
  ),
  'barbell_seated_close_grip_concentration_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit on the end of a bench with feet flat on the floor, leaning forward slightly. Hold a barbell with a narrow grip (hands 6-8 inches apart). Rest your elbows on the inside of your thighs for support. Curl the bar up toward your chest using only your biceps while keeping your upper arms stationary against your thighs. Squeeze hard at the top. Lower with control. The close grip emphasizes the inner biceps while the seated position with elbow support eliminates momentum for strict isolation.',
  ),
  'barbell_seated_military_press_inside_squat_cage': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on a bench positioned inside a squat rack with safety bars set just above head height. Position the barbell on the safety bars at forehead level. Grip the bar just outside shoulder-width. Press the bar straight up overhead until arms are fully extended. Lower back down to the safety bars and pause. Press again. The safety bars allow you to train to failure safely without a spotter, building maximum shoulder strength and power.',
  ),
  'barbell_seated_overhead_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support. Hold a barbell overhead with arms fully extended, using a shoulder-width grip. Keeping your upper arms vertical and stationary, lower the bar behind your head by bending at the elbows. Go down until you feel a deep triceps stretch. Press back up by extending your elbows. Keep your core tight and avoid leaning back. The overhead position maximizes triceps long head activation for complete arm development.',
  ),
  'barbell_side_bent_ii': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
    },
    description: 'HOW TO: Hold a barbell across your upper back and shoulders. Stand with feet shoulder-width apart, core braced. Keeping your hips facing forward and legs straight, bend to one side as far as comfortable, letting the bar dip to that side. Keep the movement in your torso only - don\'t bend forward or backward. Return to upright, then bend to the other side. This targets your obliques and builds core strength, though it should be used carefully as it can compress the spine under heavy loads.',
  ),
  'barbell_standing_close_grip_military_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold a barbell at shoulder level with a close grip (hands 6-8 inches apart). Press the bar straight up overhead until arms are fully extended, shifting your head back slightly to let the bar pass. Lock out at the top. Lower with control back to shoulders. The close grip increases triceps involvement compared to standard military press while still building powerful shoulders. Keep your core extremely tight throughout.',
  ),
  'barbell_standing_overhead_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold a barbell overhead with arms fully extended, using a shoulder-width or slightly narrower grip. Keep your upper arms vertical and locked in position. Lower the bar behind your head by bending only at the elbows until you feel a deep triceps stretch. Press back up to full extension. Keep your elbows pointing up and core tight. The standing position engages more stabilizer muscles while building powerful triceps.',
  ),
  'barbell_standing_reverse_grip_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'brachialis': 0.5,
    },
    description: 'HOW TO: Stand holding a barbell with an overhand grip (palms facing down) at shoulder-width. Let the bar hang at arm\'s length. Keep your elbows close to your sides. Curl the bar up toward your shoulders using your biceps and forearms. Squeeze at the top. Lower with control. The reverse grip shifts emphasis to the brachialis (underneath the biceps) and forearms, building thicker upper arms and exceptional grip strength.',
  ),
  'barbell_standing_twist': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold a barbell across your upper back and shoulders (use light weight or empty bar). Keep your hips and legs stationary, facing forward. Rotate your torso to the left as far as comfortable, then rotate to the right. The bar should move horizontally. Keep the movement controlled and smooth - no jerking. This builds rotational core strength and oblique development. Avoid this exercise if you have lower back issues.',
  ),
  'barbell_standing_wide_grip_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell with a wide grip (hands significantly wider than shoulder-width). Let the bar hang at arm\'s length with elbows close to your sides. Curl the bar up toward your shoulders by contracting your biceps. Keep your upper arms stationary. Squeeze hard at the top. Lower with control. The wide grip emphasizes the short head (inner biceps), building thickness in the middle of your arms for that peaked look.',
  ),
  'barbell_standing_wide_grip_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell with hands positioned well outside shoulder-width. Let the bar hang at arm\'s length. Keep your elbows locked in position at your sides. Curl the bar up toward your chest using your biceps. Focus on squeezing your biceps hard at the peak contraction. Lower the bar with control. The extra-wide grip targets the inner biceps and builds that dramatic peak when flexing your arms.',
  ),
  'barbell_standing_wide_military_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart. Hold a barbell at shoulder level with a wide grip (hands positioned outside shoulder-width). Press the bar straight up overhead until arms are fully extended. Lower back to shoulders with control. The wide grip increases the range of motion and emphasizes the lateral delts more than a standard grip, building wider shoulders and exceptional pressing strength. Keep your core braced throughout.',
  ),
  'barbell_stiff_leg_good_morning': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Place a barbell across your upper back. Stand with feet hip-width apart. Keep your legs nearly straight (slight knee bend only) throughout. Push your hips back and bend forward at the waist until your torso is roughly parallel to the floor. Keep your back flat and core tight. Feel an intense stretch in your hamstrings. Drive your hips forward to return to standing. This variation maximizes hamstring stretch and development while building a strong lower back.',
  ),
  'barbell_straight_leg_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand holding a barbell with an overhand grip at hip level. Keep your legs nearly straight (slight knee bend only) throughout. Push your hips back and lower the bar by bending at the waist, keeping the bar close to your legs. Keep your back flat. Lower until you feel a strong hamstring stretch (bar around mid-shin). Drive your hips forward to return to standing. This Romanian deadlift variation emphasizes hamstring and lower back development with minimal quad involvement.',
  ),
  'barbell_wide_reverse_grip_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
      'biceps': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench. Grip the barbell with an underhand grip (palms facing your face) with hands wider than shoulder-width. Unrack the bar and position it above your chest. Lower the bar to your mid-chest, keeping elbows at roughly 45 degrees from your body. Press back up powerfully. The wide reverse grip creates unique chest activation patterns while also engaging the biceps and reducing shoulder strain, offering a fresh stimulus for chest growth.',
  ),
  'bench_dip_knees_bent': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'front_delts': 0.6,
    },
    description: 'HOW TO: Sit on the edge of a bench with hands gripping the edge next to your hips. Slide your hips off the bench with knees bent at 90 degrees and feet flat on the floor. Lower your body by bending your elbows until your upper arms are roughly parallel to the floor. Press back up by extending your elbows. Keep your back close to the bench. Bent knees make this easier than straight-leg bench dips, making it perfect for beginners building triceps strength.',
  ),
  'butt_ups': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
    },
    description: 'HOW TO: Lie on your back with legs extended straight up toward the ceiling, perpendicular to your body. Place your arms at your sides on the floor. Keep your legs straight and together. Use your lower abs to lift your hips up off the floor, pressing your feet toward the ceiling. Your hips should come 3-6 inches off the ground. Lower with control. Focus on using your abs to drive the movement, not momentum. This movement isolates the lower abs intensely.',
  ),
  'cable_alternate_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing away from a cable machine with a rope or handle attached to the high pulley. Hold one end in each hand with arms bent and hands at head level. Step forward to create tension. Extend one arm straight out in front of you by straightening at the elbow. Return to start, then extend the other arm. Continue alternating. Keep your elbows in a fixed position. The alternating pattern allows you to focus on each arm individually while maintaining constant tension.',
  ),
  'cable_bar_lateral_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
    },
    description: 'HOW TO: Sit at a lat pulldown machine with a straight bar attached. Grip the bar with hands at shoulder-width or slightly wider. Lean back slightly and keep your chest up. Pull the bar down to your upper chest by driving your elbows down and back. Squeeze your lats hard. Control the bar back up with tension. Focus on pulling with your back muscles, not your arms. This classic exercise builds wide, powerful lats and a V-taper physique.',
  ),
  'cable_biceps_curl_sz_bar': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Attach an SZ curl bar (EZ bar) to the low pulley of a cable machine. Stand facing the machine, grab the bar with an underhand grip. Step back to create tension. Keep your elbows close to your sides. Curl the bar up toward your shoulders by contracting your biceps. Squeeze at the top. Lower with control. The SZ bar reduces wrist strain compared to a straight bar while the cable provides constant tension throughout the movement for maximum biceps activation.',
  ),
  'cable_close_grip_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Attach a straight bar or close-grip handle to the low pulley of a cable machine. Stand facing the machine, grab the handle with hands close together (4-6 inches apart). Step back to create tension. Keep your elbows pinned to your sides. Curl the handle up toward your chest by contracting your biceps. Squeeze hard at the top. Lower with control. The close grip emphasizes the outer biceps (long head) for better peak development.',
  ),
  'cable_close_grip_front_lat_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
    },
    description: 'HOW TO: Sit at a lat pulldown machine with a close-grip handle or V-bar attached. Grip with hands 4-6 inches apart, palms facing each other. Lean back slightly and pull the handle down to your upper chest by driving your elbows down and back. Focus on squeezing your lats, not just pulling with your arms. Control the weight back up. The close grip allows for a greater range of motion and increased lat stretch, building thickness in your mid and lower lats.',
  ),
  'cable_concentration_extension_on_knee': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Kneel on one knee beside a low cable pulley. Attach a single handle. Grab the handle with one hand and position your elbow on your raised knee (same side), upper arm vertical. Your elbow should be supported and stationary. Extend your forearm down by straightening your elbow, contracting your tricep. Squeeze at full extension. Return with control. The supported position eliminates momentum and isolates the triceps perfectly for detailed arm development.',
  ),
  'cable_cross_over_lateral_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Stand between two high cable pulleys. Grab the left handle with your right hand and the right handle with your left hand, crossing your arms. Step forward slightly to create tension. Pull both handles down and across your body in an arc motion, bringing them to your sides. Squeeze your lats hard. Return with control. The crossover angle creates unique lat activation and increases the range of motion for exceptional back width development.',
  ),
  'cable_cross_over_revers_fly': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Stand between two high cable pulleys. Grab the left handle with your right hand and right handle with your left hand, arms crossed in front of you. Step back slightly. Pull both handles apart in a wide arc, bringing them to your sides with arms extended. Focus on squeezing your rear delts and upper back. Return with control. The constant cable tension throughout the movement builds well-developed rear delts and improves posture.',
  ),
  'cable_curl_with_multipurpose_v_bar': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
      'brachialis': 0.6,
    },
    description: 'HOW TO: Attach a V-bar handle to the low pulley of a cable machine. Stand facing the machine, grab the V-bar with palms facing each other (neutral grip). Step back to create tension. Keep your elbows close to your sides. Curl the bar up toward your shoulders. Squeeze your biceps at the top. Lower with control. The neutral grip reduces wrist strain and emphasizes the brachialis, building thicker overall arm development.',
  ),
  'cable_front_shoulder_raise': ExerciseMuscleData(
    primaryMuscles: {
      'front_delts': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing away from a low cable pulley with a straight bar or rope attached. Grab the handle and step forward to create tension, starting with the cable behind you. Keep your arms straight with a slight elbow bend. Raise your arms forward and up to shoulder height or slightly above. Control the cable back down. Keep your core tight and avoid using momentum. The cable provides constant tension throughout the movement, building powerful front delts.',
  ),
  'cable_hammer_curl_with_rope_attachment_male': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'brachialis': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Attach a rope to the low pulley of a cable machine. Stand facing the machine, grab each end of the rope with palms facing each other. Step back to create tension. Keep your elbows pinned to your sides. Curl the rope up toward your shoulders while maintaining the neutral grip throughout. Squeeze hard at the top, even trying to pull the rope ends apart. Lower with control. The rope allows for natural wrist positioning while building thick biceps and forearms.',
  ),
  'cable_high_pulley_overhead_tricep_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Attach a rope to a high cable pulley. Stand facing away from the machine, grab the rope with both hands overhead. Step forward and lean slightly forward with arms bent behind your head. Extend your arms forward and down by straightening your elbows, bringing the rope over your head. Keep your upper arms stationary. Return with control. The high pulley angle creates maximum stretch in the triceps long head for complete arm development.',
  ),
  'cable_hip_adduction': ExerciseMuscleData(
    primaryMuscles: {
      'hip_adductors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Attach an ankle cuff to a low cable pulley. Stand perpendicular to the machine with the cuffed leg closest to the machine. Step away to create tension. Balance on your outside leg. Pull your cuffed leg across your body in front of your standing leg by contracting your inner thigh. Control it back to start. Complete all reps, then switch sides. This isolates the inner thigh muscles for leg development and hip stability.',
  ),
  'cable_horizontal_pallof_press': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set a cable pulley at chest height. Stand perpendicular to the machine, feet shoulder-width apart. Hold the handle with both hands at your chest. Step away to create tension. Press the handle straight out in front of you, fully extending your arms. The cable will try to rotate your torso - resist this with your core. Pull back to chest. The anti-rotation aspect builds exceptional core stability and strength for all athletic movements.',
  ),
  'cable_incline_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
    },
    description: 'HOW TO: Set an incline bench in front of a low cable pulley. Lie face-up on the bench with head at the high end. Grab a straight bar or rope attachment with arms extended overhead toward the cable machine. Keep your upper arms stationary and angled back toward the pulley. Bend at the elbows to bring the handle toward your forehead. Extend back up. The incline angle increases the stretch on the triceps while providing constant tension for maximum growth.',
  ),
  'cable_kneeling_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Attach a rope to a high cable pulley. Kneel facing the machine and grab the rope with both hands. Pull the rope down until your hands are beside your head, elbows bent and pointing up. Keep your upper arms stationary. Extend your forearms down by straightening your elbows until arms are fully extended. Squeeze your triceps. Return with control. The kneeling position stabilizes your body and allows for strict form without using momentum.',
  ),
  'cable_kneeling_triceps_extension_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'lats': 0.6,
    },
    description: 'HOW TO: Attach a rope to a high cable pulley. Kneel facing the machine, grab the rope, and pull it down overhead so it\'s behind your head. Lean forward slightly with your torso at a 45-degree angle. Keep your upper arms close to your head. Extend your forearms forward and down by straightening your elbows. Full extension, then return with control. This variation increases the range of motion and stretch on the triceps long head.',
  ),
  'cable_lat_pulldown_full_range_of_motion': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
    },
    description: 'HOW TO: Sit at a lat pulldown machine with a wide grip bar. Grab the bar with hands wide, lean back slightly, chest up. Pull the bar down to your upper chest by driving your elbows down and back. Get full contraction with the bar touching your chest. Then let the bar rise all the way up until your arms are fully extended and you feel a complete lat stretch. This full range of motion maximizes muscle activation and builds exceptional back width and thickness.',
  ),
  'cable_lying_extension_pullover_with_rope_attachment': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'lats': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench with your head near a low cable pulley. Attach a rope and grab each end with arms extended overhead toward the pulley. In one motion, pull the rope over your chest in an arc while simultaneously extending your elbows. The movement combines a pullover and triceps extension. Return with control. This hybrid exercise hits both lats and triceps, building impressive upper body strength and size.',
  ),
  'cable_lying_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench positioned in front of a low cable pulley. Grab a straight bar or rope attachment with arms extended overhead toward the cable. Keep your upper arms stationary and angled slightly back. Bend at the elbows to bring the handle toward your forehead. Extend back up by contracting your triceps. The constant cable tension throughout the movement provides a superior stimulus compared to free weights for building horseshoe triceps.',
  ),
  'cable_one_arm_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Attach a single handle to a low cable pulley. Stand facing the machine, grab the handle with one hand. Step back to create tension. Keep your elbow close to your side. Curl the handle up toward your shoulder by contracting your bicep. Squeeze hard at the top. Lower with control. Complete all reps, then switch arms. The unilateral focus allows you to address strength imbalances while the cable provides constant tension.',
  ),
  'cable_one_arm_inner_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand perpendicular to a low cable pulley with your working arm closest to the machine. Attach a single handle and grab it. Step away to create tension with your arm across your body. Curl the handle up and across toward your opposite shoulder, bringing your hand to the center of your chest. Squeeze the peak. Lower with control. This angle emphasizes the short head (inner biceps) for maximum peak development.',
  ),
  'cable_one_arm_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'side_delts': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand perpendicular to a low cable pulley. Attach a single handle and grab it with the hand farthest from the machine. Let your arm hang across your body. Raise your arm out to the side and up to shoulder height, keeping a slight bend in your elbow. Lead with your elbow, not your hand. Lower with control. Complete all reps, then switch sides. The cable provides constant tension throughout the movement, superior to dumbbells for building capped shoulders.',
  ),
  'cable_one_arm_side_triceps_pushdown': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand perpendicular to a high cable pulley. Attach a single handle and grab it with one hand at shoulder height, elbow bent. Your working arm should be closest to the machine. Push the handle down and slightly across your body by extending your elbow. Keep your upper arm stationary. Full extension, squeeze your tricep. Return with control. This angled pushdown hits the triceps from a unique angle for complete arm development.',
  ),
  'cable_overhead_triceps_extension_rope_attachment': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Attach a rope to a low cable pulley. Stand facing away from the machine, grab the rope with both hands overhead. Step forward and lean slightly forward. Your hands should be behind your head with elbows bent and pointing up. Extend your arms forward and up by straightening your elbows. Keep your upper arms stationary. Return with control. The rope allows you to pull the ends apart at full extension for maximum triceps contraction.',
  ),
  'cable_pushdown_straight_arm_ii': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a high cable pulley with a straight bar attached. Grab the bar with an overhand grip, hands shoulder-width apart. Step back slightly with arms extended at shoulder height. Keep your arms straight (slight elbow bend only). Pull the bar down in an arc toward your thighs by contracting your lats. Keep your core tight and don\'t bend your elbows. Return with control. This isolates the lats without biceps involvement, building impressive back width.',
  ),
  'cable_rear_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.5,
      'biceps': 0.5,
    },
    description: 'HOW TO: Sit at a lat pulldown machine with a wide grip bar. Grab the bar with a wide grip and lean back more than usual (about 30-45 degrees). Pull the bar down behind your head to the base of your neck. Drive your elbows down and back. Squeeze your shoulder blades together. Return with control. This variation requires good shoulder mobility and emphasizes the upper back and rear delts more than front pulldowns. Use caution if you have shoulder issues.',
  ),
  'cable_reverse_grip_straight_back_seated_high_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Sit at a cable row machine with your torso upright (not leaning back or forward). Attach a straight bar and grab it with an underhand grip (palms up). Pull the bar to your lower chest by driving your elbows straight back, keeping them close to your body. Squeeze your lats and upper back. Return with control. The reverse grip increases biceps and lower lat involvement while the upright position keeps strict form for maximum back development.',
  ),
  'cable_reverse_grip_triceps_pushdown_sz_bar': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Attach an SZ bar (EZ curl bar) to a high cable pulley. Stand facing the machine, grab the bar with an underhand grip (palms facing up). Keep your elbows close to your sides. Push the bar down by extending your elbows until arms are straight. Squeeze your triceps at the bottom. Return with control. The reverse grip shifts emphasis to the medial head of the triceps and increases forearm activation for complete arm development.',
  ),
  'cable_reverse_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Set up at a preacher bench positioned in front of a low cable pulley. Attach a straight bar. Rest your arms on the pad with an overhand grip (palms down). Keep your chest against the pad. Curl the bar up toward your shoulders using your brachialis and forearms. Squeeze at the top. Lower with control. The preacher position eliminates cheating while the reverse grip targets the brachialis and forearms for thicker, more complete arm development.',
  ),
  'cable_seated_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Sit on a bench positioned between two mid-height cable pulleys. Grab a handle in each hand at chest level. Press both handles forward by extending your arms, bringing the handles together in front of you. Squeeze your chest. Return with control. The seated position provides stability while the cables maintain constant tension throughout the movement, making this an excellent chest builder that reduces joint stress compared to barbell pressing.',
  ),
  'cable_seated_neck_extension_with_head_harness': ExerciseMuscleData(
    primaryMuscles: {
      'neck': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit on a bench facing away from a low cable pulley. Attach a head harness to the cable and secure it on your head. Lean forward slightly with your chin toward your chest. Extend your neck by lifting your head up and back against the resistance. Return with control. Use light weight and smooth movements. Building neck strength is important for injury prevention in contact sports and provides aesthetic neck development.',
  ),
  'cable_seated_neck_flexion_with_head_harness': ExerciseMuscleData(
    primaryMuscles: {
      'neck': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench facing a low cable pulley. Attach a head harness to the cable and secure it on your head. Start with your head tilted back. Flex your neck by bringing your chin down toward your chest against the resistance. Return with control. Use light weight and controlled movements. Never jerk the weight. This builds the front neck muscles, crucial for combat sports and aesthetic neck development.',
  ),
  'cable_seated_rear_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit on a bench positioned between two low cable pulleys. Lean forward until your torso is nearly parallel to the floor. Grab the left handle with your right hand and right handle with your left hand, crossing cables. Pull the handles out and up to your sides in a reverse fly motion with arms relatively straight. Squeeze your rear delts and upper back. Return with control. The cables provide constant tension for building well-rounded shoulders.',
  ),
  'cable_seated_shoulder_internal_rotation': ExerciseMuscleData(
    primaryMuscles: {
      'rotator_cuff': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.6,
    },
    description: 'HOW TO: Sit on a bench perpendicular to a cable machine set at elbow height. Grab the handle with your near arm. Position your elbow at 90 degrees, upper arm at your side, and forearm pointing toward the machine. Pull the handle across your body by rotating at your shoulder, moving your hand toward your opposite hip. Your upper arm stays still. Return with control. This strengthens the internal rotator muscles, crucial for shoulder health and injury prevention.',
  ),
  'cable_shrug': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand between two low cable pulleys or facing a low pulley. Attach handles or a straight bar. Grab the attachment and stand upright with arms hanging at your sides. Shrug your shoulders straight up toward your ears as high as possible by contracting your traps. Hold briefly at the top. Lower with control. Don\'t roll your shoulders. The constant cable tension provides superior trap activation compared to dumbbells, building impressive trap development.',
  ),
  'cable_side_bend': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand perpendicular to a low cable pulley. Attach a single handle and grab it with the hand closest to the machine. Step away to create tension. Place your other hand behind your head. Keep your hips forward and legs straight. Bend to the side away from the cable by contracting your obliques on that side. Return to upright with control. Complete all reps, then switch sides. This isolates the obliques for defined core development.',
  ),
  'cable_standing_cross_over_high_reverse_fly': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Stand between two high cable pulleys. Grab the left handle with your right hand and right handle with your left hand, arms crossed and extended in front. Bend forward at the hips to about 45 degrees. Pull both handles back and out to your sides with arms straight. Focus on squeezing your rear delts and upper back together. Return with control. The high pulley angle and forward lean maximizes rear delt activation for complete shoulder development.',
  ),
  'cable_standing_crunch_with_rope_attachment': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Attach a rope to a high cable pulley. Stand facing the machine, grab the rope with both hands. Hold the rope behind your head at neck level. Step back to create tension. Crunch down by flexing your spine and bringing your elbows toward your knees. Contract your abs hard at the bottom. Return with control, keeping tension on your abs. Standing crunches allow you to use more weight than floor crunches while the cable provides constant resistance.',
  ),
  'cable_standing_hip_extension': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Attach an ankle cuff to a low cable pulley. Face the machine and secure the cuff on one ankle. Hold onto the machine for balance. With a slight bend in your knee, kick your cuffed leg straight back by contracting your glutes and hamstrings. Keep your torso upright - don\'t lean forward. Squeeze your glutes hard at full extension. Return with control. Complete all reps, then switch legs. This isolates the glutes for superior development.',
  ),
  'cable_standing_inner_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand perpendicular to a low cable pulley with your working arm farthest from the machine. Attach a single handle and grab it so the cable runs across your body. Step away to create tension with your arm extended across your body. Curl the handle up and across toward the opposite shoulder. Squeeze hard at the peak. Lower with control. This angle specifically targets the short head (inner biceps) for maximum peak development.',
  ),
  'cable_standing_leg_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'calves': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Attach an ankle cuff to a low cable pulley. Face the machine and secure the cuff on one ankle. Hold onto the machine for balance. With your working leg slightly behind you, curl your foot up toward your glutes by bending your knee. Keep your thigh stationary. Squeeze your hamstring at the top. Lower with control. Complete all reps, then switch legs. This unilateral exercise builds hamstring strength and addresses muscle imbalances.',
  ),
  'cable_standing_reverse_curl_sz_bar': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Attach an SZ bar (EZ curl bar) to a low cable pulley. Stand facing the machine, grab the bar with an overhand grip (palms down). Step back to create tension. Keep your elbows close to your sides. Curl the bar up toward your shoulders. Squeeze at the top. Lower with control. The SZ bar reduces wrist strain compared to a straight bar while the reverse grip targets the brachialis and forearms for thicker, more complete arm development.',
  ),
  'cable_standing_shoulder_external_rotation': ExerciseMuscleData(
    primaryMuscles: {
      'rotator_cuff': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Stand perpendicular to a cable machine set at elbow height. Grab the handle with your far hand. Position your elbow at 90 degrees close to your side, forearm pointing toward the machine. Rotate your forearm away from your body by rotating at your shoulder, keeping your elbow pinned to your side. Your upper arm stays still. Return with control. This strengthens the external rotators, crucial for shoulder health, injury prevention, and throwing sports.',
  ),
  'cable_standing_up_straight_crossovers': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: Stand between two high cable pulleys with handles attached. Grab the handles and step forward with arms extended to your sides at shoulder height. Keep your torso upright (don\'t lean forward). Bring both handles down and together in front of your hips in an arc motion. Squeeze your chest hard. Return with control. The upright position and downward angle targets the lower chest fibers for complete chest development.',
  ),
  'cable_supine_reverse_fly': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Lie face-up on a bench positioned between two low cable pulleys. Grab the left handle with your right hand and right handle with your left hand, arms crossed above your chest. Pull the handles apart and out to your sides in a wide arc with arms relatively straight. Squeeze your rear delts and upper back. Return with control. The supine position provides stability while allowing for a deep stretch and strong contraction in the rear delts.',
  ),
  'cable_triceps_pushdown_sz_bar': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Attach an SZ bar (EZ curl bar) to a high cable pulley. Stand facing the machine, grab the bar with an overhand grip. Keep your elbows tucked close to your sides and upper arms stationary. Push the bar down by extending your elbows until your arms are fully straight. Squeeze your triceps hard at full extension. Return with control, stopping when forearms are parallel to the floor. The SZ bar reduces wrist strain while maintaining maximum triceps activation.',
  ),
  'cable_triceps_pushdown_v_bar_attachment': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Attach a V-bar handle to a high cable pulley. Stand facing the machine, grab the V-bar with palms facing each other. Keep your elbows tucked at your sides. Push the bar down by extending your elbows until arms are fully straight. Squeeze your triceps at full extension. Return with control. The neutral grip V-bar is comfortable on the wrists and allows for a natural pressing motion while maximizing triceps development.',
  ),
  'cable_tuck_reverse_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Attach ankle straps to a low cable pulley. Lie on your back with feet toward the machine. Pull your knees toward your chest so there\'s tension on the cable. Place hands on the floor for support. Contract your lower abs to curl your hips and knees further toward your chest, lifting your glutes off the floor. Hold and squeeze your lower abs. Return with control. The cable adds resistance to reverse crunches for advanced core development.',
  ),
  'cable_twist': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Set a cable pulley at chest height. Stand perpendicular to the machine with feet shoulder-width apart. Hold the handle with both hands at chest level, arms extended. Step away to create tension. Keep your hips and legs facing forward. Rotate your torso away from the machine, pivoting at your waist and bringing the handle across your body. Return with control. This rotational movement builds powerful obliques and functional core strength for sports and daily activities.',
  ),
  'cable_two_arm_tricep_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Stand facing a low cable pulley with a rope or two handles attached. Grab the attachment and step back. Bend forward at the hips until your torso is nearly parallel to the floor. Start with elbows bent at 90 degrees, upper arms parallel to the floor. Extend both arms straight back by straightening your elbows. Squeeze your triceps at full extension. Return with control. The cable provides constant tension throughout the entire range of motion.',
  ),
  'cable_underhand_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'lower_lats': 0.5,
    },
    description: 'HOW TO: Sit at a lat pulldown machine with a straight bar attached. Grab the bar with an underhand grip (palms facing you) at shoulder-width. Lean back slightly. Pull the bar down to your upper chest by driving your elbows down and back. Keep your chest up. Squeeze your lats hard. Control the bar back up. The underhand grip increases biceps involvement and emphasizes the lower lats for complete back development and impressive width.',
  ),
  'cable_upper_chest_crossovers': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: Stand between two low cable pulleys with handles attached. Grab the handles and step forward with arms extended down and behind you. Lean forward slightly. Bring both handles up and together in front of your upper chest in an upward arc motion. Squeeze your chest at the top. Return with control. The low-to-high angle specifically targets the upper chest fibers (clavicular head) for complete chest development and a fuller look.',
  ),
  'cable_upper_row': ExerciseMuscleData(
    primaryMuscles: {
      'upper_back': 0.0,
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'lats': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Sit or stand at a cable station with a straight bar or rope attached at upper chest height. Grab the attachment with hands at shoulder-width. Pull the handle toward your upper chest/face by driving your elbows back and up at roughly shoulder height. Focus on squeezing your upper back and rear delts together. Return with control. This high row variation builds thickness in the upper back and rear delts for improved posture and complete back development.',
  ),
  'cable_upright_row': ExerciseMuscleData(
    primaryMuscles: {
      'side_delts': 0.0,
      'traps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Attach a straight bar to a low cable pulley. Stand facing the machine, grab the bar with an overhand grip at shoulder-width or slightly narrower. Let the bar hang at arm\'s length. Pull the bar straight up along your body toward your chin by raising your elbows out to the sides. Keep the bar close to your body. Your elbows should rise higher than your hands. Lower with control. This builds powerful traps and side delts but use caution if you have shoulder issues.',
  ),
  'cable_vertical_pallof_press': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Set a cable pulley at floor level. Stand facing away from the machine with feet shoulder-width apart. Hold the handle with both hands at chest level. Step away to create tension. Press the handle straight up overhead, fully extending your arms. The cable will try to pull you backward - resist this with your core. Pull back down to chest level. This vertical anti-extension pattern builds exceptional core stability and overhead strength.',
  ),
  'cable_wide_grip_behind_neck_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.5,
      'biceps': 0.5,
    },
    description: 'HOW TO: Sit at a lat pulldown machine with a wide grip bar. Grab the bar with hands positioned wide (1.5-2x shoulder width). Pull the bar down behind your head to the base of your neck. Drive your elbows down and back. Squeeze your shoulder blades together. Return with control. This variation requires excellent shoulder mobility and emphasizes the upper back and lats. Only perform if you have healthy shoulders and good mobility.',
  ),
  'cable_wide_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
    },
    description: 'HOW TO: Sit at a lat pulldown machine with a wide grip bar. Grab the bar with hands positioned wide (1.5-2x shoulder width). Lean back slightly with chest up. Pull the bar down to your upper chest by driving your elbows down and out to the sides. Focus on squeezing your lats, thinking about pulling your elbows to your hips. Return with control. The wide grip maximizes lat width development for that coveted V-taper physique.',
  ),
  'cable_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Attach a straight bar to a low cable pulley. Kneel or sit facing the machine. Rest your forearms on a bench or your thighs with palms facing up, wrists hanging off the edge. Grab the bar and let it roll down to your fingers. Curl your wrists up by contracting your forearms, bringing the bar as high as possible. Hold the squeeze. Lower with control. The constant cable tension provides superior forearm development compared to dumbbells or barbells.',
  ),
  'chest_dip': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Grip parallel bars and support yourself at arm\'s length. Lean your torso forward at roughly 30-45 degrees. Lower yourself by bending your elbows, letting them flare out slightly, until you feel a stretch in your chest. Go as deep as comfortable. Press back up by contracting your chest and triceps. The forward lean shifts emphasis to the chest. Dips are one of the best bodyweight chest builders and can be loaded with a weight belt for progression.',
  ),
  'chin_ups_narrow_parallel_grip': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Hang from parallel grip handles (palms facing each other) positioned close together. Start from a dead hang with arms fully extended. Pull yourself up by driving your elbows down and back until your chin clears the bar. Keep your chest up. Lower with control to full extension. The narrow parallel grip is extremely biceps-dominant while still hitting the lats, and is easier on the wrists and shoulders than wide grip pull-ups.',
  ),
  'close_grip_chin_up': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Hang from a pull-up bar with an underhand grip (palms facing you) and hands positioned close together (6-8 inches apart). Start from a dead hang. Pull yourself up by driving your elbows down until your chin clears the bar. Keep your chest up. Lower with control. The close underhand grip maximizes biceps activation while still building powerful lats, making this an exceptional compound movement for upper body pulling strength.',
  ),
  'cocoons': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie flat on your back with arms extended overhead and legs straight. In one motion, simultaneously crunch your upper body up while bringing your knees to your chest, wrapping your arms around your legs into a tight ball (like a cocoon). Squeeze your abs hard in this tucked position. Extend back out to the starting position with control. This dynamic movement hits the entire core through a full range of motion for exceptional ab development.',
  ),
  'cross_body_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back with hands behind your head, elbows wide. Bend your knees with feet flat on the floor. Crunch your upper body up while simultaneously bringing your right knee toward your chest and rotating your left elbow to meet your right knee. Return to start. Repeat on the other side, left knee to right elbow. Continue alternating. This rotational crunch targets the obliques and entire core for defined, functional midsection development.',
  ),
  'crunch_floor_m': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back on the floor with knees bent and feet flat. Place your hands behind your head, elbows out to the sides. Engage your abs and curl your upper back off the floor, lifting your shoulders toward your hips. Only your shoulder blades should come off the floor. Keep your lower back pressed down. Hold briefly at the top, squeezing your abs hard. Lower with control. Basic floor crunches are a fundamental core exercise that never goes out of style.',
  ),
  'crunch_on_stability_ball': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Sit on a stability ball and walk your feet forward until your lower back is supported on the ball. Place your hands behind your head. Your body should be in a slight arch over the ball. Crunch forward by contracting your abs, curling your upper body up. Go until your abs are fully contracted. Return to the stretched position over the ball. The ball increases the range of motion and engages stabilizer muscles for superior core development.',
  ),
  'decline_push_up_m': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Place your feet on an elevated surface (bench, box, or stairs) and hands on the floor in push-up position. Your body should form a straight line from head to heels at a decline angle. Lower your chest to the floor by bending your elbows. Push back up to full extension. The decline angle increases the difficulty and shifts emphasis to the upper chest and front delts, building impressive upper body pressing strength.',
  ),
  'dumbbell_alternate_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing your thighs. Keep your elbows close to your sides. Curl one dumbbell up toward your shoulder while rotating your wrist so your palm faces up at the top. Squeeze your bicep. Lower with control while simultaneously curling the other arm. Continue alternating. The alternating pattern allows you to focus on each arm individually and use slightly heavier weight than simultaneous curls.',
  ),
  'dumbbell_arnold_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit or stand holding dumbbells at shoulder height with palms facing you (like the top of a curl). Press the dumbbells up while simultaneously rotating your hands so your palms face forward at the top. Reverse the motion on the way down, ending with palms facing you again. This rotation engages all three delt heads through a greater range of motion than standard presses, building complete 3D shoulder development.',
  ),
  'dumbbell_arnold_press_ii': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand or sit on a bench with back support. Hold dumbbells at shoulder level with palms facing your body. Press the weights up overhead while rotating your palms to face forward at the top. At the peak, your arms should be fully extended with palms facing away. Reverse the rotation as you lower. This variation of the Arnold Press provides constant tension and hits all three delt heads for complete shoulder development.',
  ),
  'dumbbell_bench_seated_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support. Hold dumbbells at shoulder level with palms facing forward, elbows bent at 90 degrees. Press both dumbbells straight up overhead until arms are fully extended. Dumbbells can touch at the top or stay slightly apart. Lower with control back to shoulder level. The seated position with back support provides stability, allowing you to focus purely on shoulder strength and lift heavier weight safely.',
  ),
  'dumbbell_bench_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Hold dumbbells at your sides. Stand in front of a bench. Squat down by pushing your hips back and bending your knees until you lightly touch the bench with your glutes. Don\'t sit or relax on the bench. Immediately drive through your heels to stand back up. The bench serves as a depth marker for consistent squats while the dumbbells provide resistance. This builds powerful legs with less spinal loading than barbell squats.',
  ),
  'dumbbell_bent_over_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
      'lower_back': 0.6,
    },
    description: 'HOW TO: Hold dumbbells with arms hanging straight down. Bend forward at the hips until your torso is roughly parallel to the floor. Keep your back flat and core tight. Pull both dumbbells up to your sides by driving your elbows back. Squeeze your shoulder blades together at the top. Lower with control. This bent-over row variation builds thick lats and upper back while allowing each side to work independently for balanced development.',
  ),
  'dumbbell_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward. Keep your elbows close to your sides and upper arms stationary. Curl both dumbbells up toward your shoulders by contracting your biceps. Squeeze hard at the top. Lower with control. Don\'t let your elbows drift forward or use momentum. Standard dumbbell curls are a foundational biceps exercise that allows for full range of motion and natural wrist rotation.',
  ),
  'dumbbell_biceps_curl_reverse': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Stand holding dumbbells with an overhand grip (palms facing down). Keep your elbows close to your sides. Curl the dumbbells up toward your shoulders, maintaining the overhand grip throughout. Squeeze at the top. Lower with control. The reverse grip shifts emphasis to the brachialis (underneath the biceps) and forearms, building thicker upper arms and exceptional grip strength for pulling movements.',
  ),
  'dumbbell_close_grip_press': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench holding two dumbbells. Press them together at arm\'s length above your chest, palms facing each other. Keep the dumbbells pressed together throughout. Lower them to your chest by bending your elbows, keeping them close to your body. Press back up while maintaining pressure between the dumbbells. The close grip and inward pressure maximizes triceps and inner chest activation.',
  ),
  'dumbbell_concentration_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit on a bench with legs spread. Hold a dumbbell in one hand, arm hanging down. Brace your elbow against the inside of your thigh for support. Curl the dumbbell up toward your shoulder, focusing purely on your bicep. Squeeze hard at the peak contraction. Lower with control. The supported position eliminates momentum and isolates the biceps completely. This exercise is legendary for building the biceps peak.',
  ),
  'dumbbell_cross_body_hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'brachialis': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand holding a dumbbell in one hand at your side with palm facing your body. Keep your elbow close to your side. Curl the dumbbell up and across your body toward your opposite shoulder, maintaining the neutral grip. Squeeze at the top. Lower with control. Complete all reps, then switch arms. The cross-body path increases the range of motion and builds the brachialis and biceps peak.',
  ),
  'dumbbell_cross_body_hammer_curl_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'brachialis': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand with dumbbells at your sides, palms facing your body. Alternately curl each dumbbell up and across your torso toward the opposite shoulder while keeping the neutral grip. As you curl one arm, the other stays at your side. The alternating cross-body motion maximizes brachialis engagement and allows you to focus on squeezing each bicep individually for peak development.',
  ),
  'dumbbell_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet hip-width apart, holding dumbbells at your sides. Push your hips back and bend your knees slightly, lowering the dumbbells along your legs. Keep your back flat and chest up. Lower until you feel a hamstring stretch or the dumbbells reach mid-shin. Drive through your heels and thrust your hips forward to stand up. Dumbbells allow for a more natural movement path than barbells while building total body strength and power.',
  ),
  'dumbbell_decline_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on a decline bench (feet higher than head) holding dumbbells at chest level. Press both dumbbells up until arms are fully extended above your lower chest. Lower with control, allowing dumbbells to travel slightly wider and deeper than barbell would allow. The decline angle targets the lower chest fibers while the dumbbells provide greater range of motion and allow each side to work independently.',
  ),
  'dumbbell_decline_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.6,
    },
    description: 'HOW TO: Lie on a decline bench holding dumbbells above your chest with arms slightly bent, palms facing each other. Lower the dumbbells out to the sides in a wide arc, keeping the same elbow bend throughout. Go until you feel a deep stretch across your chest. Bring the dumbbells back together above your chest, squeezing your chest hard. The decline angle emphasizes lower chest development for complete pec development.',
  ),
  'dumbbell_decline_hammer_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on a decline bench holding dumbbells with a neutral grip (palms facing each other). Press the dumbbells up from your chest until arms are fully extended, maintaining the neutral grip throughout. Lower with control. The neutral grip is easier on the shoulders and allows for a more natural pressing path while the decline angle targets the lower chest for complete chest development.',
  ),
  'dumbbell_decline_shrug': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Lie face-down on a decline bench with dumbbells hanging straight down toward the floor. Keep your arms straight. Shrug your shoulders up by contracting your traps, bringing your shoulder blades together. Hold at the top. Lower with control. The decline position provides a unique angle on the traps and eliminates momentum, forcing your traps to work throughout the entire range of motion.',
  ),
  'dumbbell_decline_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
    },
    description: 'HOW TO: Lie on a decline bench with head at the low end. Hold dumbbells with arms extended above your chest. Keep your upper arms stationary. Bend at the elbows to lower the dumbbells toward your ears or temples. Extend back up by contracting your triceps. The decline angle increases the stretch on the triceps while providing a different stimulus than flat or incline variations for complete triceps development.',
  ),
  'dumbbell_finger_curls': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding dumbbells with palms facing up. Rest your forearms on your thighs with wrists hanging off your knees. Let the dumbbells roll down to your fingertips with fingers extended. Using only your fingers and grip, curl the dumbbells back up into your palms by flexing your fingers closed. Hold the squeeze. Lower with control. This isolation exercise builds exceptional finger strength and forearm development.',
  ),
  'dumbbell_goblet_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Hold a single dumbbell vertically at chest height with both hands cupping the top weight. Stand with feet shoulder-width apart. Keep the weight close to your chest with elbows pointing down. Squat down by pushing hips back and bending knees, keeping your chest up and core tight. Go as deep as possible while maintaining form. Drive through your heels to stand. The front-loaded weight naturally keeps you upright, making this excellent for learning proper squat mechanics.',
  ),
  'dumbbell_hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'brachialis': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing each other (neutral grip). Keep your elbows close to your sides. Curl both dumbbells up toward your shoulders while maintaining the neutral grip throughout. Squeeze at the top. Lower with control. Hammer curls target the brachialis and brachioradialis more than standard curls, building thicker overall arm development and exceptional grip strength.',
  ),
  'dumbbell_hammer_curl_ii': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'brachialis': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Stand with dumbbells at your sides, palms facing your thighs. Keep your upper arms locked at your sides. Curl the dumbbells simultaneously toward your shoulders, keeping the neutral hammer grip throughout the movement. Focus on squeezing at the top. Lower with control. This variation builds the brachialis underneath the biceps, pushing your biceps up and out for thicker, more impressive arms.',
  ),
  'dumbbell_high_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells and raise your arms out to your sides at shoulder height with elbows bent at 90 degrees, like a double biceps pose. Curl one dumbbell up toward your head by moving only your forearm. Your upper arm stays parallel to the floor. Lower with control, then curl the other side. The high elbow position creates peak contraction in the biceps and engages the front delts for a complete upper arm pump.',
  ),
  'dumbbell_incline_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Lie on an incline bench set to 30-45 degrees. Hold dumbbells at chest level with arms bent. Press both dumbbells up until arms are fully extended above your upper chest. Lower with control, allowing dumbbells to go deeper than a barbell would. The incline angle targets the upper chest (clavicular head) while dumbbells provide greater range of motion and allow each side to work independently for balanced development.',
  ),
  'dumbbell_incline_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.6,
    },
    description: 'HOW TO: Lie on an incline bench set to 30-45 degrees. Hold dumbbells above your chest with arms slightly bent, palms facing each other. Lower the dumbbells out to the sides in a wide arc, maintaining the elbow bend. Go until you feel a deep stretch across your upper chest. Bring the dumbbells back together above your chest by squeezing your chest. The incline angle specifically targets the upper chest for complete pec development.',
  ),
  'dumbbell_incline_front_raise': ExerciseMuscleData(
    primaryMuscles: {
      'front_delts': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie back on an incline bench set to 45 degrees holding dumbbells at your sides. With arms straight (slight elbow bend), raise both dumbbells forward and up in an arc until they\'re above your head. Keep your arms relatively straight throughout. Lower with control. The incline position provides constant tension and eliminates the ability to cheat, forcing your front delts to work through the entire range of motion.',
  ),
  'dumbbell_incline_inner_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Lie back on an incline bench set to 45-60 degrees. Let dumbbells hang at your sides with arms fully extended and palms facing forward. Curl the dumbbells up toward your shoulders, keeping your elbows back and pinned to your sides. Squeeze hard at the top. Lower with control to full stretch. The incline creates an intense stretch on the biceps and emphasizes the short head (inner biceps) for peak development.',
  ),
  'dumbbell_incline_raise': ExerciseMuscleData(
    primaryMuscles: {
      'front_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Lie chest-down on an incline bench set to 30-45 degrees. Hold dumbbells with arms hanging straight down. Raise both dumbbells forward and up in an arc until your arms are roughly parallel to the floor. Keep your arms relatively straight. Lower with control. This variation eliminates momentum and isolates the front delts from a unique angle, building powerful shoulders with constant tension.',
  ),
  'dumbbell_incline_rear_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Lie face-down on an incline bench set to 30-45 degrees with chest supported. Hold dumbbells with arms hanging straight down. Raise both dumbbells out to your sides in a wide arc with arms relatively straight until they reach shoulder height. Focus on squeezing your rear delts and upper back. Lower with control. The incline position eliminates momentum and provides chest support for perfect rear delt isolation.',
  ),
  'dumbbell_incline_reverse_grip_30_degrees_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on an incline bench set to 30 degrees. Hold dumbbells with an underhand grip (palms facing your face). Press the dumbbells up from chest level until arms are fully extended. Lower with control. The reverse grip combined with the 30-degree incline creates unique upper chest activation while engaging the biceps more than standard pressing, providing a fresh stimulus for chest growth.',
  ),
  'dumbbell_incline_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Lie face-down on an incline bench set to 30-45 degrees with chest supported. Hold dumbbells with arms hanging straight down. Pull both dumbbells up to your sides by driving your elbows back. Squeeze your shoulder blades together at the top. Lower with control. The chest support eliminates lower back strain and momentum, allowing pure lat and upper back work with perfect form.',
  ),
  'dumbbell_incline_shrug': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Lie face-down on an incline bench with dumbbells hanging straight down. Keep your arms straight. Shrug your shoulders up toward your ears by contracting your traps, bringing your shoulder blades together. Hold at the top. Lower with control. The incline position targets the upper and middle traps from a unique angle while eliminating momentum, building impressive trap development and upper back thickness.',
  ),
  'dumbbell_incline_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie back on an incline bench holding dumbbells with arms extended above your head toward the ceiling. Keep your upper arms stationary and angled back slightly. Bend at the elbows to lower the dumbbells toward your temples or behind your head. Extend back up by contracting your triceps. The incline provides constant tension on the triceps throughout the movement for exceptional arm development.',
  ),
  'dumbbell_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides. Step forward with one leg, landing heel first. Lower your back knee toward the floor until your front thigh is parallel to the ground. Your front knee should stay behind your toes. Push through your front heel to return to standing. Alternate legs or complete all reps on one side first. Dumbbell lunges build unilateral leg strength, balance, and explosive power while addressing muscle imbalances.',
  ),
  'dumbbell_lying_elbow_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells. Start with your elbows bent at 90 degrees, upper arms parallel to the floor, and dumbbells at chest level. Press the dumbbells up by extending your arms until fully extended above your chest. Lower back down with control. The focus on elbow extension emphasizes triceps while still engaging the chest, providing a unique stimulus for upper body pressing strength.',
  ),
  'dumbbell_lying_femoral': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'calves': 0.6,
    },
    description: 'HOW TO: Lie face-down on a flat bench. Secure a dumbbell between your feet (squeeze it with both feet). With legs straight, curl your feet up toward your glutes by bending your knees. Squeeze your hamstrings hard at the top. Lower with control. This makeshift leg curl builds hamstring strength when no leg curl machine is available, though balance and coordination are required.',
  ),
  'dumbbell_lying_hammer_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells with a neutral grip (palms facing each other). Press the dumbbells up from your chest until arms are fully extended, maintaining the neutral grip throughout. Lower with control. The neutral grip is easier on the shoulders and allows for a natural pressing motion while still building powerful chest development. This variation also increases triceps involvement.',
  ),
  'dumbbell_lying_hammer_press_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie flat on a bench with dumbbells held above your chest, palms facing each other in a neutral grip. Keep the dumbbells close together throughout. Press up to full extension, then lower the weights down toward the center of your chest while maintaining the hammer grip. The close neutral grip path emphasizes the inner chest and triceps while being shoulder-friendly.',
  ),
  'dumbbell_lying_rear_delt_row': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Lie face-down on a flat bench with dumbbells hanging straight down. Pull both dumbbells up toward your sides with elbows flaring out wide at roughly 90 degrees from your body. Focus on squeezing your rear delts and upper back together. Lower with control. The lying position eliminates momentum and lower back strain, allowing perfect rear delt and upper back isolation.',
  ),
  'dumbbell_lying_single_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding one dumbbell overhead with one arm extended. Keep your upper arm vertical and stationary. Bend at the elbow to lower the dumbbell toward the opposite shoulder or behind your head. Extend back up by contracting your tricep. Complete all reps, then switch arms. The unilateral focus addresses strength imbalances while the lying position provides stability for strict form.',
  ),
  'dumbbell_lying_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells with arms extended above your chest. Keep your upper arms perpendicular to the floor and locked in position. Bend at the elbows to lower the dumbbells toward your ears or temples. Extend back up by contracting your triceps. The dumbbells allow for natural wrist positioning and independent arm work, building symmetrical triceps development.',
  ),
  'dumbbell_one_arm_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Place one knee and hand on a bench for support. Hold a dumbbell in your free hand. Position your upper arm parallel to the floor with elbow bent at 90 degrees. Extend your forearm back by straightening your elbow until your arm is fully extended. Squeeze your tricep hard. Return with control. Complete all reps, then switch sides. This isolation exercise perfectly targets the triceps with zero momentum.',
  ),
  'dumbbell_one_arm_revers_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding a dumbbell in one hand with an overhand grip (palm facing down). Rest your forearm on your thigh with wrist hanging off your knee. Lower the dumbbell by extending your wrist down. Curl your wrist up by contracting your forearm extensors. Hold the squeeze. Lower with control. Complete all reps, then switch arms. This builds the top of the forearms for balanced arm development.',
  ),
  'dumbbell_one_arm_row_rack_support': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Place one hand on a squat rack or sturdy support at roughly waist height. Bend forward at the hips with your back flat. Hold a dumbbell in your free hand, arm hanging straight down. Pull the dumbbell up to your side by driving your elbow back. Focus on squeezing your lat and upper back. Lower with control. The rack support provides stability for heavy rowing.',
  ),
  'dumbbell_one_arm_seated_neutral_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding a dumbbell in one hand with a neutral grip (thumb up). Rest your forearm on your thigh with wrist hanging off your knee. Let the dumbbell drop by flexing your wrist down. Curl your wrist up by contracting your forearm. Hold the squeeze. Lower with control. The neutral grip targets different forearm muscles than pronated or supinated curls for complete forearm development.',
  ),
  'dumbbell_one_arm_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding a dumbbell in one hand with an underhand grip (palm facing up). Rest your forearm on your thigh with wrist hanging off your knee. Let the dumbbell roll down to your fingertips. Curl your wrist up by contracting your forearm flexors. Hold the squeeze. Lower with control. Complete all reps, then switch arms. The unilateral focus ensures balanced forearm development.',
  ),
  'dumbbell_over_bench_neutral_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Kneel behind a flat bench holding dumbbells with a neutral grip (palms facing each other). Rest your forearms on the bench with wrists hanging off the edge. Let the dumbbells drop by flexing your wrists down. Curl your wrists up by contracting your forearms. Hold the squeeze. Lower with control. This position allows for heavy loading and builds the side forearm muscles for complete arm development.',
  ),
  'dumbbell_over_bench_one_arm__neutral_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Kneel beside a flat bench. Hold a dumbbell in one hand with a neutral grip (thumb up). Rest your forearm on the bench with wrist hanging off the edge. Lower the dumbbell by flexing your wrist down. Curl your wrist up by contracting your forearm. Hold at the top. Lower with control. Complete all reps, then switch arms. This unilateral variation ensures no strength imbalances in forearm development.',
  ),
  'dumbbell_over_bench_one_arm_reverse_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Kneel beside a flat bench. Hold a dumbbell in one hand with an overhand grip (palm down). Rest your forearm on the bench with wrist hanging off the edge. Lower the dumbbell by dropping your wrist. Curl your wrist up by contracting your forearm extensors. Hold the squeeze. Lower with control. Complete all reps, then switch. This builds the top of the forearms for balanced arm aesthetics.',
  ),
  'dumbbell_over_bench_one_arm_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Kneel beside a flat bench. Hold a dumbbell in one hand with an underhand grip (palm up). Rest your forearm on the bench with wrist hanging off the edge. Let the dumbbell roll to your fingertips. Curl your wrist up by contracting your forearm flexors, bringing the dumbbell back into your palm. Hold at the top. Lower with control. Complete all reps, then switch arms.',
  ),
  'dumbbell_over_bench_revers_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Kneel behind a flat bench holding dumbbells with an overhand grip (palms down). Rest your forearms on the bench with wrists hanging off the edge. Lower the dumbbells by dropping your wrists down. Curl your wrists up by contracting your forearm extensors. Hold the squeeze at the top. Lower with control. This builds the extensor muscles on top of the forearms for complete balanced development.',
  ),
  'dumbbell_over_bench_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Kneel behind a flat bench holding dumbbells with an underhand grip (palms up). Rest your forearms on the bench with wrists hanging off the edge. Let the dumbbells roll down to your fingertips. Curl your wrists up by contracting your forearm flexors, bringing the dumbbells back into your palms. Hold the squeeze. Lower with control. This position allows for maximum range of motion and heavy loading.',
  ),
  'dumbbell_palm_rotational_bent_over_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Bend forward at the hips with dumbbells hanging straight down, palms facing your body. Pull both dumbbells up to your sides while simultaneously rotating your wrists so your palms face backward at the top. Squeeze your lats and upper back. Lower while rotating palms back to starting position. The rotation adds an extra dimension to the row, increasing back activation and building functional pulling strength.',
  ),
  'dumbbell_palms_in_incline_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on an incline bench set to 30-45 degrees. Hold dumbbells with a neutral grip (palms facing each other). Press the dumbbells up from chest level until arms are fully extended, maintaining the neutral grip throughout. Lower with control. The neutral grip combined with incline angle targets the upper chest while being extremely shoulder-friendly, making this ideal for those with shoulder issues.',
  ),
  'dumbbell_peacher_hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Sit at a preacher bench with chest against the pad. Hold dumbbells with a neutral grip (palms facing each other), arms extended down the pad. Curl both dumbbells up toward your shoulders while maintaining the neutral grip. Squeeze at the top. Lower with control. The preacher position eliminates momentum while the hammer grip emphasizes the brachialis for thicker overall arm development.',
  ),
  'dumbbell_pullover': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Lie perpendicular on a flat bench with only your upper back supported. Hold a single dumbbell with both hands above your chest, arms extended. Lower the dumbbell back in an arc over and behind your head until you feel a deep stretch in your lats and chest. Pull the dumbbell back up over your chest. This classic exercise expands the rib cage and builds both lat width and chest thickness.',
  ),
  'dumbbell_rear_delt_raise': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Bend forward at the hips until your torso is nearly parallel to the floor. Hold dumbbells with arms hanging down. Raise both dumbbells out to your sides in a wide arc with arms relatively straight until they reach shoulder height. Focus on leading with your elbows and squeezing your rear delts. Lower with control. This fundamental exercise builds well-rounded shoulders and improves posture.',
  ),
  'dumbbell_rear_delt_row': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Bend forward at the hips with dumbbells hanging straight down. Pull both dumbbells up toward your sides with elbows flaring out wide at roughly 90 degrees from your body. Focus on driving through your elbows and squeezing your rear delts and upper back. Lower with control. The wide elbow angle specifically targets the rear delts more than standard rows for complete shoulder development.',
  ),
  'dumbbell_rear_fly': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Bend forward at the hips until your torso is nearly parallel to the floor. Hold dumbbells with arms hanging down and palms facing each other. Raise both dumbbells out to your sides in a wide arc with arms relatively straight. Focus on squeezing your rear delts and upper back together. Lower with control. This isolation exercise is essential for balanced shoulder development and preventing injuries.',
  ),
  'dumbbell_rear_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Stand or sit bent forward at the hips, torso nearly parallel to the floor. Hold dumbbells with arms hanging straight down. Raise both dumbbells out to your sides with arms straight until they reach shoulder height. Lead with your elbows, keeping a slight bend. Squeeze your rear delts hard. Lower with control. Building strong rear delts is crucial for shoulder health, posture, and complete development.',
  ),
  'dumbbell_rear_lunge': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides. Step one leg backward, landing on the ball of your back foot. Lower your back knee toward the floor until your front thigh is parallel to the ground. Push through your front heel to return to standing. Alternate legs. Rear lunges are easier on the knees than forward lunges while building powerful quads, glutes, and unilateral leg strength.',
  ),
  'dumbbell_revers_grip_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Stand holding dumbbells with an overhand grip (palms facing down). Keep your elbows close to your sides. Curl both dumbbells up toward your shoulders, maintaining the overhand grip throughout. Squeeze at the top. Lower with control. The reverse grip shifts emphasis to the brachialis and forearm extensors, building thicker arms and exceptional grip strength.',
  ),
  'dumbbell_reverse_bench_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'biceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on a flat bench holding dumbbells with an underhand grip (palms facing your face). Press the dumbbells up from your chest until arms are fully extended. Lower with control. The reverse grip creates unique chest activation patterns while engaging the biceps more than standard pressing, reduces shoulder strain, and provides a novel stimulus for chest growth.',
  ),
  'dumbbell_reverse_grip_incline_bench_two_arm_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Lie face-down on an incline bench with chest supported. Hold dumbbells with an underhand grip (palms facing up), arms hanging straight down. Pull both dumbbells up to your sides by driving your elbows back, keeping them close to your body. Squeeze your lats. Lower with control. The reverse grip increases biceps and lower lat involvement while the incline provides perfect support for isolation.',
  ),
  'dumbbell_reverse_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Sit at a preacher bench with chest against the pad. Hold dumbbells with an overhand grip (palms facing down), arms extended down the pad. Curl the dumbbells up toward your shoulders, maintaining the overhand grip. Squeeze at the top. Lower with control. The preacher position eliminates cheating while the reverse grip targets the brachialis and forearms for complete arm development.',
  ),
  'dumbbell_reverse_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding dumbbells with an overhand grip (palms facing down). Rest your forearms on your thighs with wrists hanging off your knees. Lower the dumbbells by dropping your wrists down. Curl your wrists up by contracting your forearm extensors. Hold the squeeze. Lower with control. This builds the extensor muscles on top of the forearms for balanced arm development and grip strength.',
  ),
  'dumbbell_romanian_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs. Keep your legs nearly straight with a slight knee bend. Push your hips back and lower the dumbbells down the front of your legs by hinging at the hips. Keep your back flat. Lower until you feel a strong hamstring stretch (around mid-shin). Drive your hips forward to stand up. RDLs are one of the best hamstring and glute builders available.',
  ),
  'dumbbell_seated_bench_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
    },
    description: 'HOW TO: Sit on a bench holding a single dumbbell with both hands overhead, arms fully extended. Keep your upper arms vertical and stationary. Lower the dumbbell behind your head by bending at the elbows. Go until you feel a deep triceps stretch. Extend back up by contracting your triceps. The seated position provides stability while the overhead position maximizes triceps long head activation.',
  ),
  'dumbbell_seated_bent_arm_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'side_delts': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding dumbbells at your sides with elbows bent at 90 degrees. Keep your elbows bent throughout. Raise your elbows out to the sides until they reach shoulder height. Lead with your elbows, not your hands. Squeeze your side delts at the top. Lower with control. The bent arm position allows for heavier weight and reduces strain on the elbow joints.',
  ),
  'dumbbell_seated_bicep_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit on a bench with dumbbells at your sides, palms facing forward. Keep your back straight and elbows close to your sides. Curl both dumbbells up toward your shoulders. Squeeze hard at the top. Lower with control. The seated position eliminates leg drive and lower body momentum, forcing your biceps to do all the work for strict isolation and maximum growth.',
  ),
  'dumbbell_seated_front_raise': ExerciseMuscleData(
    primaryMuscles: {
      'front_delts': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Sit on a bench holding dumbbells in front of your thighs with palms facing your legs. Keep your arms relatively straight with a slight elbow bend. Raise both dumbbells forward and up to shoulder height. Lower with control. The seated position eliminates momentum and forces strict form, making your front delts do all the work for targeted shoulder development.',
  ),
  'dumbbell_seated_hammer_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'brachialis': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Sit on a bench holding dumbbells at your sides with palms facing each other (neutral grip). Keep your back straight and elbows at your sides. Curl both dumbbells up toward your shoulders while maintaining the neutral grip. Squeeze at the top. Lower with control. The seated position ensures strict form while the hammer grip builds the brachialis for thicker arms.',
  ),
  'dumbbell_seated_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on the edge of a bench leaning forward with your torso at 45 degrees. Hold dumbbells with upper arms parallel to the floor and elbows bent at 90 degrees. Extend both forearms back simultaneously by straightening your elbows. Squeeze your triceps at full extension. Return with control. The seated position provides stability for strict triceps isolation.',
  ),
  'dumbbell_seated_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'side_delts': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding dumbbells at your sides with arms hanging down. Keep a slight bend in your elbows. Raise both dumbbells out to your sides until they reach shoulder height. Lead with your elbows, not your hands. Pause at the top, squeezing your side delts. Lower with control. The seated position eliminates momentum for perfect side delt isolation and capped shoulder development.',
  ),
  'dumbbell_seated_neutral_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding dumbbells with a neutral grip (thumbs up). Rest your forearms on your thighs with wrists hanging off your knees. Let the dumbbells drop by flexing your wrists down. Curl your wrists up by contracting your forearms. Hold the squeeze. Lower with control. The neutral grip targets different forearm fibers than supinated or pronated grips for complete forearm development.',
  ),
  'dumbbell_seated_palms_up_wrist_curl': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit on a bench holding dumbbells with an underhand grip (palms facing up). Rest your forearms on your thighs with wrists hanging off your knees. Let the dumbbells roll down to your fingertips. Curl your wrists up by contracting your forearm flexors. Hold the squeeze. Lower with control. This fundamental forearm exercise builds the flexor muscles on the underside of your forearms.',
  ),
  'dumbbell_seated_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a preacher bench with your chest against the pad. Hold dumbbells with palms facing up, arms extended down the pad. Curl both dumbbells up toward your shoulders. Squeeze your biceps hard at the peak. Lower with control to full extension. The preacher position eliminates momentum and provides constant tension throughout the entire range of motion for maximum biceps development.',
  ),
  'dumbbell_seated_revers_grip_concentration_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Sit on a bench with legs spread. Hold a dumbbell in one hand with an overhand grip (palm down). Brace your elbow against the inside of your thigh. Curl the dumbbell up toward your shoulder while maintaining the overhand grip. Squeeze at the top. Lower with control. Complete all reps, then switch. The reverse grip concentration curl builds the brachialis and forearms with zero momentum.',
  ),
  'dumbbell_seated_shoulder_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit on a bench with back support. Hold dumbbells at shoulder level with elbows bent at 90 degrees, palms facing forward. Press both dumbbells straight up overhead until arms are fully extended. Lower with control back to shoulder level. The seated position with back support provides stability, allowing you to lift heavier weight safely and focus purely on building massive shoulders.',
  ),
  'dumbbell_seated_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on a bench holding a single dumbbell with both hands overhead, arms fully extended. Keep your upper arms vertical and stationary. Lower the dumbbell behind your head by bending at the elbows until you feel a deep triceps stretch. Extend back up by contracting your triceps. The seated position provides stability while maximizing triceps long head activation for horseshoe arms.',
  ),
  'dumbbell_shrug': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with arms hanging straight down. Shrug your shoulders straight up toward your ears as high as possible by contracting your traps. Hold briefly at the top. Lower with control. Don\'t roll your shoulders. Keep the movement straight up and down. Dumbbell shrugs allow for a natural movement path and build impressive trap development for a powerful physique.',
  ),
  'dumbbell_side_bend': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Stand holding a dumbbell in one hand at your side. Place your other hand behind your head or on your hip. Keep your legs straight and hips facing forward. Bend to the side with the dumbbell, lowering it down your leg. Return to upright by contracting your obliques on the opposite side. Complete all reps, then switch sides. This isolates the obliques for core strength and definition.',
  ),
  'dumbbell_single_leg_split_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Hold dumbbells at your sides. Place your rear foot on a bench behind you. Your front foot should be far enough forward that your knee stays behind your toes when you lower down. Lower your back knee toward the floor until your front thigh is parallel to the ground. Push through your front heel to stand up. Complete all reps, then switch legs. Bulgarian split squats build unilateral leg strength and address imbalances.',
  ),
  'dumbbell_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with feet shoulder-width apart. Keep your chest up and core tight. Squat down by pushing your hips back and bending your knees until thighs are at least parallel to the floor. Keep your weight on your heels. Drive through your heels to stand back up. Dumbbells allow for a natural squatting motion and are easier on the back than barbells, making them perfect for home training.',
  ),
  'dumbbell_standing_alternate_raise': ExerciseMuscleData(
    primaryMuscles: {
      'front_delts': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs with palms facing your legs. Keep your arms relatively straight with a slight elbow bend. Raise one dumbbell forward and up to shoulder height or slightly above. Lower it with control while simultaneously raising the other arm. Continue alternating. The alternating pattern allows you to use slightly heavier weight and maintain better balance throughout the set.',
  ),
  'dumbbell_standing_bent_over_two_arm_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.6,
      'lower_back': 0.6,
    },
    description: 'HOW TO: Bend forward at the hips until your torso is nearly parallel to the floor. Hold dumbbells with upper arms parallel to the floor and elbows bent at 90 degrees. Extend both forearms back simultaneously by straightening your elbows until arms are fully extended. Squeeze your triceps hard. Return with control. This bent-over position maximizes triceps activation while engaging core and lower back stabilizers.',
  ),
  'dumbbell_standing_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward. Keep your feet shoulder-width apart and core tight. Curl both dumbbells up toward your shoulders by contracting your biceps. Keep your elbows stationary at your sides. Squeeze hard at the top. Lower with control. Standing curls engage more stabilizer muscles than seated variations, building functional strength and bigger biceps.',
  ),
  'dumbbell_standing_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand on an elevated surface with the balls of your feet on the edge and heels hanging off. Hold dumbbells at your sides. Lower your heels below the platform to stretch your calves fully. Push up onto your toes as high as possible by contracting your calves. Squeeze maximally at the top. Lower with control. Standing calf raises build the gastrocnemius (upper calf) for explosive lower leg power.',
  ),
  'dumbbell_standing_concentration_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with feet wider than shoulder-width. Bend forward slightly and brace your elbow against the inside of your thigh with arm hanging down. Hold a dumbbell in that hand. Curl the dumbbell up toward your shoulder while keeping your elbow pressed against your thigh. Squeeze your bicep hard. Lower with control. Complete all reps, then switch arms. The standing position adds a core challenge to the traditional concentration curl.',
  ),
  'dumbbell_standing_inner_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells with a wide stance, arms hanging at your sides. As you curl, bring the dumbbells up and inward toward the center of your chest rather than straight up. This inward path emphasizes the short head (inner biceps). Squeeze hard at the peak. Lower with control. This curl variation builds the inner biceps for that dramatic peak when flexing.',
  ),
  'dumbbell_standing_inner_biceps_curl_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand with dumbbells at your sides. Curl both dumbbells simultaneously while rotating your wrists outward and bringing the weights toward the center of your body. At the top, your palms should be facing up and the dumbbells close to your chest. This supination and inward path maximizes short head (inner biceps) activation for peak development.',
  ),
  'dumbbell_standing_kickback': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
      'lower_back': 0.6,
    },
    description: 'HOW TO: Stand in a staggered stance, bent forward at the hips. Hold dumbbells with upper arms parallel to your torso and elbows bent. Extend both forearms back simultaneously by straightening your elbows. Squeeze your triceps at full extension. Return with control. The standing position requires more core stability than the bench-supported version, building functional triceps strength.',
  ),
  'dumbbell_standing_one_arm_concentration_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand with legs wide. Bend forward and brace your non-working hand on your thigh for support. Let your working arm hang with a dumbbell. Brace your elbow against your inner thigh. Curl the dumbbell up toward your shoulder. Squeeze your bicep intensely. Lower with control. The standing position engages your core while the braced elbow eliminates momentum for pure biceps isolation.',
  ),
  'dumbbell_standing_one_arm_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding a dumbbell overhead in one hand with arm fully extended. Keep your upper arm vertical and stationary. Lower the dumbbell behind your head by bending at the elbow. Go until you feel a deep triceps stretch. Extend back up by contracting your tricep. Complete all reps, then switch arms. The unilateral overhead position maximizes triceps long head activation.',
  ),
  'dumbbell_standing_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand holding a single dumbbell with both hands overhead, arms fully extended. Keep your upper arms vertical and stationary. Lower the dumbbell behind your head by bending at the elbows. Go until you feel a deep triceps stretch. Extend back up by contracting your triceps. The standing position engages core stabilizers while building powerful triceps.',
  ),
  'dumbbell_step_up': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a bench or box holding dumbbells at your sides. Step up onto the box with one foot, driving through your heel to lift your body up. Bring your other foot up to meet it. Step back down with control. Alternate leading legs or complete all reps on one leg first. Step-ups build unilateral leg strength, power, and address muscle imbalances while being easier on the back than squats.',
  ),
  'dumbbell_stiff_leg_deadlift': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'glutes': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs. Keep your legs nearly straight with only a slight knee bend. Push your hips back and lower the dumbbells by bending at the waist. Keep your back flat and dumbbells close to your legs. Lower until you feel an intense hamstring stretch. Drive your hips forward to stand up. This variation maximizes hamstring stretch and development.',
  ),
  'dumbbell_straight_arm_pullover': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'chest': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on a flat bench holding a dumbbell with both hands above your chest. Keep your arms nearly straight with just a slight elbow bend throughout. Lower the dumbbell back in an arc over and behind your head until you feel a deep stretch. Pull the dumbbell back up over your chest. Straight-arm pullovers emphasize the lats more than bent-arm versions, building impressive back width.',
  ),
  'dumbbell_upright_row': ExerciseMuscleData(
    primaryMuscles: {
      'side_delts': 0.0,
      'traps': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs with palms facing your body. Pull both dumbbells straight up along your body toward your chin by raising your elbows out to the sides. Your elbows should rise higher than your hands. Keep the dumbbells close to your body. Lower with control. This builds powerful traps and side delts but use caution if you have shoulder issues.',
  ),
  'dumbbell_upright_row_back_pov': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
      'side_delts': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Stand holding dumbbells in front of your thighs. Pull the dumbbells straight up by raising your elbows high and out to the sides. Focus on driving your elbows up and back, squeezing your shoulder blades together at the top. This back-focused variation emphasizes the upper back and rear delts more than standard upright rows, building complete shoulder and trap development.',
  ),
  'dumbbell_upright_shoulder_external_rotation': ExerciseMuscleData(
    primaryMuscles: {
      'rotator_cuff': 0.0,
    },
    secondaryMuscles: {
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Stand holding light dumbbells with elbows bent at 90 degrees and upper arms at your sides. Your forearms should point straight ahead. Rotate your forearms up and out to the sides by externally rotating at your shoulders. Keep your elbows pinned at your sides. Your forearms should end up pointing toward the ceiling. Return with control. This strengthens the rotator cuff for shoulder health and injury prevention.',
  ),
  'dumbbell_zottman_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'brachialis': 0.5,
    },
    description: 'HOW TO: Stand holding dumbbells at your sides with palms facing forward. Curl the dumbbells up toward your shoulders with an underhand grip. At the top, rotate your wrists so palms face down. Lower the dumbbells with this overhand grip. At the bottom, rotate palms back to facing forward. The rotation combines a standard curl on the way up with a reverse curl on the way down for complete arm development.',
  ),
  'dumbbells_seated_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on a bench holding dumbbells overhead with arms fully extended. Keep your upper arms vertical and close to your head. Lower both dumbbells behind your head by bending at the elbows. Go until you feel a deep triceps stretch. Extend back up by contracting your triceps. Using two dumbbells allows each arm to work independently, ensuring balanced triceps development.',
  ),
  'elbow_to_knee': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Stand with feet shoulder-width apart, hands behind your head. Lift your right knee up while simultaneously crunching your left elbow down to meet it. Return to start. Repeat on the other side, left knee to right elbow. Continue alternating. This standing core exercise builds obliques and coordination while providing a cardio element. Keep the movement controlled, not rushed.',
  ),
  'extra_decline_sit_up': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on a steep decline bench with feet secured at the top. Place hands behind your head or across chest. Curl your torso up against gravity until you\'re sitting upright. The steep decline increases resistance significantly. Lower back down with control, using your abs to resist the downward pull. This advanced variation builds exceptional core strength and should only be attempted after mastering regular decline sit-ups.',
  ),
  'ez_bar_reverse_grip_bent_over_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Hold an EZ curl bar with an underhand grip. Bend forward at the hips until your torso is roughly parallel to the floor. Let the bar hang at arm\'s length. Pull the bar up to your lower chest by driving your elbows back, keeping them close to your body. Squeeze your lats and upper back. Lower with control. The EZ bar provides a comfortable wrist angle while the reverse grip increases biceps and lower lat involvement.',
  ),
  'ez_bar_seated_close_grip_concentration_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit on a bench leaning forward. Hold an EZ curl bar with a close grip (hands close together on the inner angles). Rest your elbows on your inner thighs. Curl the bar up toward your chest using only your biceps. Squeeze hard at the top. Lower with control. The close grip emphasizes the outer biceps while the EZ bar provides a natural wrist angle and the seated position eliminates momentum.',
  ),
  'ez_barbell_close_grip_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding an EZ curl bar with a close grip (hands positioned on the inner angled portion). Let the bar hang at arm\'s length. Keep your elbows close to your sides. Curl the bar up toward your shoulders. Squeeze your biceps at the top. Lower with control. The close grip emphasizes the outer biceps (long head) while the EZ bar reduces wrist strain compared to a straight bar.',
  ),
  'ez_barbell_close_grip_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a preacher bench with your chest against the pad. Hold an EZ curl bar with a close grip on the inner angles. Rest your arms on the pad with arms extended. Curl the bar up toward your shoulders. Squeeze your biceps hard. Lower with control to full extension. The preacher position eliminates cheating while the close grip targets the outer biceps for peak development.',
  ),
  'ez_barbell_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand holding an EZ curl bar at the angled grips, arms hanging at your sides. Keep your elbows close to your sides and upper arms stationary. Curl the bar up toward your shoulders by contracting your biceps. Squeeze hard at the top. Lower with control. The EZ bar\'s angled grip reduces wrist and forearm strain compared to straight bars, allowing you to lift heavier and build bigger biceps.',
  ),
  'ez_barbell_decline_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.6,
    },
    description: 'HOW TO: Lie on a decline bench holding an EZ curl bar with arms extended above your chest. Keep your upper arms stationary. Bend at the elbows to lower the bar toward your forehead or past your head. Extend back up by contracting your triceps. The decline angle increases the stretch on the triceps while the EZ bar provides a comfortable wrist angle for heavy pressing.',
  ),
  'ez_barbell_incline_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Lie on an incline bench holding an EZ curl bar with arms extended overhead. Keep your upper arms stationary and angled back. Bend at the elbows to lower the bar toward your head or behind. Extend back up by contracting your triceps. The incline provides constant tension throughout the movement while the EZ bar allows for a natural wrist angle.',
  ),
  'ez_barbell_reverse_grip_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Stand holding an EZ curl bar with an overhand grip (palms facing down) at the angled sections. Let the bar hang at arm\'s length. Keep your elbows close to your sides. Curl the bar up toward your shoulders. Squeeze at the top. Lower with control. The reverse grip targets the brachialis and forearms while the EZ bar makes the movement more comfortable than a straight bar.',
  ),
  'ez_barbell_reverse_grip_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Sit at a preacher bench with chest against the pad. Hold an EZ curl bar with an overhand grip (palms down), arms extended down the pad. Curl the bar up toward your shoulders while maintaining the overhand grip. Squeeze at the top. Lower with control. The preacher position eliminates momentum while the reverse grip builds the brachialis and forearms for thicker arms.',
  ),
  'ez_barbell_seated_curls': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit on a bench with feet flat on the floor. Hold an EZ curl bar at the angled grips, arms hanging down. Keep your elbows at your sides. Curl the bar up toward your shoulders by contracting your biceps. Squeeze hard at the top. Lower with control. The seated position eliminates leg drive and momentum, forcing your biceps to do all the work.',
  ),
  'ez_barbell_seated_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Sit on a bench holding an EZ curl bar overhead with arms fully extended. Keep your upper arms vertical and stationary. Lower the bar behind your head by bending at the elbows. Go until you feel a deep triceps stretch. Extend back up by contracting your triceps. The EZ bar provides a comfortable wrist angle while the seated position ensures strict form.',
  ),
  'finger_curls': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit holding a barbell or dumbbells with palms facing up. Rest your forearms on your thighs with wrists hanging off your knees. Let the weight roll down to your fingertips with fingers extended. Using only your fingers, curl the weight back up into your palms by flexing your fingers closed. Hold the squeeze. Lower with control. This builds exceptional finger strength and forearm development for crushing grip strength.',
  ),
  'flutter_kicks_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Lie flat on your back with hands under your glutes for support. Lift both legs slightly off the ground. Alternately kick your legs up and down in a flutter motion, keeping legs straight. Keep your lower back pressed to the floor and core engaged. The kicks should be small and rapid. This variation burns the lower abs and hip flexors while building endurance.',
  ),
  'flutter_kicks_version_3': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Lie on your back with hands under your glutes. Lift your legs 6-12 inches off the ground. Perform quick alternating up and down kicks with straight legs. Keep your core tight and lower back pressed down. Focus on controlled movements from the hip, not swinging legs. Continue for time or reps. This advanced variation maintains constant tension on the lower abs and hip flexors.',
  ),
  'front_plank': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'shoulders': 0.5,
      'glutes': 0.6,
    },
    description: 'HOW TO: Start in a push-up position but with forearms on the ground instead of hands. Your elbows should be directly under your shoulders. Form a straight line from head to heels. Engage your core, squeeze your glutes, and keep your back flat. Don\'t let your hips sag or pike up. Hold this position. The plank is a fundamental core exercise that builds incredible anterior core strength and full-body stability.',
  ),
  'hack_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Position yourself in a hack squat machine with shoulders under the pads and back against the support. Place the balls of your feet on the edge of the platform with heels hanging off. Lower your heels below the platform to stretch your calves fully. Push up onto your toes as high as possible by contracting your calves. Squeeze hard at the top. Lower with control. The machine allows for heavy loading and stable calf training.',
  ),
  'half_wipers_bent_leg': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back with arms extended out to the sides for stability. Bend your knees at 90 degrees and lift them so your thighs are perpendicular to the floor. Keep your knees bent throughout. Rotate your legs to one side, lowering your knees toward the floor while keeping your shoulders flat. Return to center, then rotate to the other side. This builds obliques and rotational core strength.',
  ),
  'hammer_grip_pull_up_on_dip_cage': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Grab the parallel bars of a dip cage with palms facing each other (neutral grip). Hang from the bars with arms fully extended. Pull yourself up by driving your elbows down until your chin clears the bars. Lower with control to full extension. The neutral grip is easier on the shoulders and wrists while maximizing biceps involvement and building a powerful back.',
  ),
  'hanging_leg_hip_raise': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with arms fully extended. Keep your legs straight. Lift your legs up by flexing your hips and engaging your lower abs until your legs are roughly parallel to the floor or higher. At the top, curl your pelvis up slightly by contracting your abs. Lower with control. This advanced exercise builds exceptional lower ab and hip flexor strength while challenging grip endurance.',
  ),
  'hanging_oblique_knee_raise': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with arms extended. Bring your knees up toward one shoulder by rotating your torso and contracting your obliques. Lower with control. Bring your knees up toward the opposite shoulder. Continue alternating. This rotational movement targets the obliques intensely while building grip strength and core control.',
  ),
  'hanging_straight_leg_hip_raise': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with arms extended and legs straight. Lift your legs up until they\'re parallel to the floor or higher, keeping them completely straight. At the top, tilt your pelvis up by contracting your lower abs. Lower with control. This is one of the most challenging ab exercises, building incredible core strength and requiring substantial grip endurance.',
  ),
  'hanging_straight_twisting_leg_hip_raise': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Hang from a pull-up bar with legs straight. Lift your legs up while simultaneously twisting your hips to one side. Your legs should end up parallel to the floor but rotated. Lower with control. Repeat to the other side. This advanced movement combines leg raises with rotation for complete core development, building the abs, obliques, and hip flexors while testing grip strength.',
  ),
  'hip_raise_bent_knee': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on your back with knees bent and feet flat on the floor close to your glutes. Place your arms at your sides. Contract your lower abs to lift your hips off the floor, bringing your knees toward your chest. Your lower back should curl up off the floor. Hold and squeeze your abs. Lower with control. This bent-knee variation is easier than straight-leg raises while still building strong lower abs.',
  ),
  'hyperextension_on_bench': ExerciseMuscleData(
    primaryMuscles: {
      'lower_back': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
    },
    description: 'HOW TO: Lie face-down on a flat bench positioned so your hips are at the edge and your upper body hangs off. Have a partner hold your legs or secure your feet. Cross your arms over your chest. Lower your torso down toward the floor by bending at the hips. Raise back up by contracting your lower back and glutes until your body forms a straight line. This builds exceptional lower back and glute strength.',
  ),
  'hyperextension_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'lower_back': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
    },
    description: 'HOW TO: Position yourself in a hyperextension bench with ankles secured and hips supported by the pad. Cross your arms over your chest or behind your head. Lower your torso down by bending at the hips until you feel a stretch in your hamstrings and lower back. Raise back up by contracting your lower back, glutes, and hamstrings until your body is straight. Don\'t hyperextend at the top.',
  ),
  'incline_leg_hip_raise_leg_straight': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on an incline bench with your head at the high end. Grab the top of the bench for support. Keep your legs straight and together. Lift your legs up by contracting your lower abs until they\'re perpendicular to your body or higher. Curl your pelvis up at the top. Lower with control. The incline increases the difficulty and range of motion for advanced ab development.',
  ),
  'incline_reverse_grip_push_up': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Place your hands on an elevated surface (bench or box) with fingers pointing backward toward your feet. Assume a push-up position with feet on the ground. Lower your chest to the elevated surface by bending your elbows. Press back up. The reverse grip is awkward but creates unique forearm and wrist strength while the incline makes it more manageable than flat-ground reverse grip push-ups.',
  ),
  'incline_twisting_sit_up_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on an incline bench with feet secured at the top. Place hands behind your head. Sit up and simultaneously twist your torso to one side, bringing your elbow toward the opposite knee. Lower back down. On the next rep, twist to the other side. Continue alternating. The incline increases resistance while the twist targets the obliques for complete core development.',
  ),
  'incline_twisting_situp': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
    },
    description: 'HOW TO: Lie on an incline bench with feet secured. Place hands behind your head. Sit up while twisting your torso, bringing your right elbow toward your left knee. Lower back down. Next rep, twist the other direction. The combination of incline and rotation builds powerful abs and obliques while challenging your entire core through a full range of motion.',
  ),
  'inverse_leg_curl_on_pull_up_cable_machine': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'calves': 0.6,
      'glutes': 0.6,
    },
    description: 'HOW TO: Stand facing a cable machine. Attach an ankle cuff to a low pulley and secure it to one ankle. Step back to create tension. Curl your foot up toward your glutes by bending your knee against the cable resistance. Keep your thigh stationary. Squeeze your hamstring at the top. Lower with control. Complete all reps, then switch legs. This cable variation provides constant tension for hamstring development.',
  ),
  'inverted_row_bent_knees': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Set a bar at waist height. Lie underneath it with knees bent and feet flat on the floor. Grab the bar with an overhand grip, hands shoulder-width apart. Keep your body straight from knees to shoulders. Pull your chest up to the bar by driving your elbows back. Lower with control. Bent knees make this easier than straight-leg inverted rows while still building powerful back strength.',
  ),
  'jackknife_sit_up': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie flat on your back with arms extended overhead and legs straight. Simultaneously lift your legs and upper body, reaching your hands toward your feet. Try to touch your toes at the top, forming a V-shape with your body. Lower back down with control. This dynamic movement hits the entire core through a full range of motion for exceptional ab development.',
  ),
  'lever_alternate_biceps_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a lever biceps curl machine with arms extended on the pads. Grip the handles with palms up. Curl one handle up toward your shoulder by contracting your bicep while the other arm stays extended. Lower it, then curl the other arm. Continue alternating. The machine provides a fixed path and constant tension while the alternating pattern allows you to focus on each arm individually.',
  ),
  'lever_alternate_leg_extension_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a plate-loaded leg extension machine with back against the pad. Hook one shin behind the lever arm pad. Extend that leg straight out by contracting your quad. Squeeze at the top. Lower with control. Complete all reps, then switch legs. The alternating unilateral approach addresses strength imbalances while the plate-loaded machine provides smooth, adjustable resistance.',
  ),
  'lever_bicep_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a lever biceps curl machine with your upper arms resting on the pads. Grip the handles with palms up. Curl the handles up toward your shoulders by contracting your biceps. Squeeze hard at the top. Lower with control. The machine provides a stable, fixed path that isolates the biceps perfectly, allowing you to focus purely on contraction without worrying about stabilization.',
  ),
  'lever_calf_press_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a plate-loaded calf press machine. Place the balls of your feet on the platform with heels hanging off. Lower your heels below the platform to fully stretch your calves. Press through the balls of your feet to raise your heels as high as possible. Squeeze your calves hard at the top. Lower with control. The machine allows for heavy loading in a stable position for maximum calf development.',
  ),
  'lever_calf_raise_bench_press_machine': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Position yourself in a bench press or leg press machine specifically designed for calf raises. Place the balls of your feet on the edge of the platform with heels hanging off. Lower your heels to stretch your calves fully. Press up onto your toes as high as possible. Squeeze hard at the top. Lower with control. The machine provides stable support for heavy calf training.',
  ),
  'lever_chair_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Sit in a lever squat machine with back against the pad and shoulders under the supports. Place feet shoulder-width apart on the platform. Release the safety and lower down by bending your knees, descending as if sitting in a chair. Go at least to parallel. Drive through your heels to press back up. The machine provides a guided path, making it safer than free weight squats while still building powerful legs.',
  ),
  'lever_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Sit in a lever chest press machine with back against the pad. Grip the handles at chest level. Press the handles forward until your arms are fully extended. Squeeze your chest. Return with control. The machine provides a stable pressing path and allows you to safely train to failure without a spotter, making it excellent for building chest strength and size.',
  ),
  'lever_chest_press_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Sit in a plate-loaded chest press machine with back supported. Grab the handles at chest level. Press forward until arms are fully extended. Squeeze your chest hard. Return with control. Plate-loaded machines provide a smooth, natural feel similar to free weights while offering the stability and safety of a machine, perfect for heavy chest pressing.',
  ),
  'lever_chest_press_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Sit at a lever chest press machine with your back against the pad. Position the handles at mid-chest level. Press the levers forward by extending your arms until fully straight. Focus on squeezing your chest throughout. Return with control. This machine variation provides a slightly different angle or grip than standard machines, offering fresh stimulus for chest growth.',
  ),
  'lever_chest_press_version_4': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Position yourself in a lever chest press machine with back firmly against the pad. Grip the handles and press forward until arms are extended. Return with control. This particular machine variation may offer a unique grip, angle, or movement path that targets the chest differently than other chest press machines, providing variety in your pressing movements.',
  ),
  'lever_deadlift_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
      'glutes': 0.0,
      'lower_back': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.5,
      'upper_back': 0.5,
      'forearms': 0.6,
    },
    description: 'HOW TO: Stand on the platform of a plate-loaded deadlift machine. Grip the handles with feet hip-width apart. Keep your back flat and chest up. Drive through your heels and extend your hips to stand up straight, pulling the weight up. Lower with control by pushing your hips back. The machine provides a guided path while still requiring full-body coordination, building total posterior chain strength.',
  ),
  'lever_decline_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Position yourself on a decline lever chest press machine with your body angled downward. Grip the handles at upper chest level. Press forward and down until arms are fully extended. Squeeze your lower chest. Return with control. The decline angle specifically targets the lower chest fibers for complete pec development while the machine ensures safety and proper form.',
  ),
  'lever_decline_chest_press_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Sit in a decline lever press machine with body positioned on a downward angle. Press the handles away from you until arms are straight. Focus on contracting your lower chest throughout. Return with control. This variation may offer a different decline angle or grip compared to other machines, providing unique stimulus for lower chest development.',
  ),
  'lever_donkey_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.6,
    },
    description: 'HOW TO: Position yourself in a donkey calf raise machine bent forward at the hips with the pad across your lower back. Place the balls of your feet on the platform with heels hanging off. Lower your heels to fully stretch your calves. Press up onto your toes as high as possible. Squeeze hard. The bent-over position and machine loading allows for exceptional calf stretch and heavy resistance for maximum development.',
  ),
  'lever_front_pulldown': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
    },
    description: 'HOW TO: Sit at a lever pulldown machine. Grip the handles overhead. Pull the levers down in front of you to your upper chest by driving your elbows down and back. Squeeze your lats. Return with control. Lever machines provide smooth, consistent resistance throughout the entire range of motion, making them excellent for building lat width and back thickness.',
  ),
  'lever_full_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Position yourself in a lever squat machine with shoulders under the pads. Place feet shoulder-width apart. Descend as deep as possible, going well below parallel until your hamstrings touch your calves. Drive through your heels to stand back up. The machine guides the movement while allowing for ass-to-grass depth, building maximum leg development with reduced injury risk.',
  ),
  'lever_gripless_shrug': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand in a lever shrug machine with shoulder pads resting on your shoulders (no need to grip handles). Keep your arms relaxed at your sides. Shrug your shoulders straight up toward your ears by contracting your traps. Hold at the top. Lower with control. The gripless design eliminates forearm fatigue, allowing you to focus purely on building massive traps.',
  ),
  'lever_gripless_shrug_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position yourself under the shoulder pads of a gripless shrug machine. Stand upright with pads on your shoulders. Shrug straight up as high as possible by contracting your traps. Squeeze hard at the top. Lower with control. This variation may offer a different pad angle or machine design, but the principle remains the same: isolate the traps without grip fatigue.',
  ),
  'lever_gripper_hands_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'forearms': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit at a plate-loaded gripper machine. Place your hands in the gripper handles with palms facing each other. Squeeze the handles together by contracting your forearms and grip muscles. Hold the squeeze. Release with control. Plate-loaded grippers allow for progressive overload of grip strength, building exceptional crushing power and forearm development.',
  ),
  'lever_hammer_grip_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.5,
    },
    description: 'HOW TO: Sit at a lever preacher curl machine with arms on the pad. Grip the handles with a neutral grip (palms facing each other). Curl the handles up toward your shoulders. Squeeze at the top. Lower with control. The hammer grip emphasizes the brachialis while the preacher position eliminates momentum, building thicker arms with perfect isolation.',
  ),
  'lever_high_row_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'upper_back': 0.0,
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'lats': 0.5,
      'biceps': 0.6,
    },
    description: 'HOW TO: Sit at a plate-loaded high row machine with chest against the pad. Grip the handles at or above shoulder height. Pull the handles toward your upper chest/face by driving your elbows back and up. Squeeze your shoulder blades together. Return with control. High rows build thickness in the upper back and rear delts for improved posture and complete back development.',
  ),
  'lever_hip_extension_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
    },
    description: 'HOW TO: Position yourself in a lever hip extension machine with your hips against the pad. Secure your ankles under the support. With a slight bend in your knees, push your hips forward and up by contracting your glutes and hamstrings. Squeeze hard at full extension. Return with control. This machine isolates the posterior chain for building powerful glutes and hamstrings.',
  ),
  'lever_incline_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Sit in an incline lever chest press machine with back against the angled pad. Grip the handles at upper chest level. Press the handles up and forward until arms are fully extended. Squeeze your upper chest. Return with control. The incline angle targets the upper chest (clavicular head) while the machine provides stability for safe, heavy pressing.',
  ),
  'lever_incline_hammer_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Sit in an incline chest press machine with neutral grip handles (palms facing each other). Press the handles forward and up until arms are extended. Squeeze your upper chest. Return with control. The neutral hammer grip is easier on the shoulders while the incline angle builds the upper chest for a full, rounded pec development.',
  ),
  'lever_kneeling_leg_curl_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'calves': 0.6,
    },
    description: 'HOW TO: Kneel on the pad of a plate-loaded leg curl machine with one knee. Secure your ankle under the lever arm. Curl your foot up toward your glutes by contracting your hamstring. Keep your thigh vertical. Squeeze at the top. Lower with control. Complete all reps, then switch legs. The kneeling position provides a unique angle for hamstring development.',
  ),
  'lever_lateral_pulldown_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'upper_back': 0.5,
    },
    description: 'HOW TO: Sit at a plate-loaded lat pulldown machine. Grip the handles overhead. Pull the levers down to your upper chest by driving your elbows down and back. Focus on squeezing your lats. Return with control. Plate-loaded pulldowns provide smooth, natural resistance similar to free weights while ensuring proper form and allowing safe training to failure.',
  ),
  'lever_lateral_raise': ExerciseMuscleData(
    primaryMuscles: {
      'side_delts': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever lateral raise machine with arms at your sides against the pads. Press your arms out and up to the sides until they reach shoulder height. Lead with your elbows. Squeeze your side delts at the top. Lower with control. The machine provides consistent resistance throughout the movement, making it superior to dumbbells for isolating the side delts.',
  ),
  'lever_lateral_raise_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'side_delts': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit at a plate-loaded lateral raise machine with your arms positioned against the pads. Press outward and upward until your arms reach shoulder height. Focus on leading with your elbows and squeezing your side delts. Lower with control. Plate-loaded machines offer smooth, adjustable resistance for building capped shoulders with perfect isolation.',
  ),
  'lever_leg_extension': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever leg extension machine with back against the pad. Hook your shins under the padded lever arm. Extend your legs straight out by contracting your quads. Squeeze hard at full extension. Lower with control. Leg extensions provide pure quad isolation, building strength and definition in all four quad muscles, especially the vastus medialis (teardrop).',
  ),
  'lever_leg_extension_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a plate-loaded leg extension machine with your back supported. Position your shins behind the pad. Extend both legs straight out by contracting your quads. Squeeze maximally at the top. Lower with control. Plate-loaded machines provide smooth resistance and allow for micro-loading, perfect for progressive quad development.',
  ),
  'lever_lying_chest_press_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Lie on your back in a plate-loaded chest press machine. Grip the handles at chest level. Press the levers up until your arms are fully extended. Squeeze your chest. Return with control. The lying position changes the angle of chest activation compared to seated presses, providing variety in your chest training while the machine ensures safety.',
  ),
  'lever_lying_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie back in a lever crunch machine with the pad positioned across your chest. Crunch forward by flexing your spine and bringing the pad down toward your hips. Contract your abs hard. Return with control. The machine provides consistent resistance throughout the crunch movement, making it superior to bodyweight crunches for building defined, strong abs.',
  ),
  'lever_lying_leg_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'calves': 0.6,
    },
    description: 'HOW TO: Lie face-down on a lever leg curl machine with your knees just off the edge of the bench. Hook your ankles under the padded lever arm. Curl your feet toward your glutes by contracting your hamstrings. Squeeze hard at the top. Lower with control. This is the gold standard for hamstring isolation, building strength and size in all three hamstring muscles.',
  ),
  'lever_lying_t_bar_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Lie face-down on a lever T-bar row machine with chest supported on the pad. Grip the handles with both hands. Pull the handles up toward your chest by driving your elbows back. Squeeze your lats and upper back together. Lower with control. The chest support eliminates lower back strain while allowing you to focus purely on back muscle contraction.',
  ),
  'lever_military_press_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit in a plate-loaded military press machine with back against the pad. Grip the handles at shoulder height. Press straight up overhead until arms are fully extended. Lower with control back to shoulder level. Plate-loaded machines provide a smooth, natural pressing motion while offering the stability needed to safely train heavy for massive shoulder development.',
  ),
  'lever_neck_extension_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'neck': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position yourself in a plate-loaded neck extension machine with the pad against the back of your head. Start with your head flexed forward. Extend your neck by pushing your head back against the pad. Return with control. Use light weight and smooth movements. Building neck strength is crucial for contact sports and provides aesthetic neck development.',
  ),
  'lever_neck_left_side_flexion_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'neck': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a plate-loaded neck flexion machine with the pad positioned against the left side of your head. Start with your head tilted to the right. Flex your neck to the left by pushing against the pad. Return with control. Use light weight. Neck side flexion builds the sternocleidomastoid and other neck muscles for strength, injury prevention, and aesthetic development.',
  ),
  'lever_neck_right_side_flexion_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'neck': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a plate-loaded neck flexion machine with the pad against the right side of your head. Start with your head tilted to the left. Flex your neck to the right by pushing against the pad. Return with control. Use light weight and controlled movements. Training both sides ensures balanced neck development and reduces injury risk.',
  ),
  'lever_neutral_grip_seated_row_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Sit at a plate-loaded row machine with chest against the pad. Grip the handles with a neutral grip (palms facing each other). Pull the handles toward your chest by driving your elbows straight back. Squeeze your shoulder blades together. Return with control. The neutral grip is comfortable on the wrists and provides excellent lat and mid-back development.',
  ),
  'lever_overhand_triceps_dip': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'front_delts': 0.6,
    },
    description: 'HOW TO: Position yourself in a lever-assisted dip machine. Grip the handles with palms facing down (overhand grip). Keep your torso upright. Lower yourself by bending your elbows until upper arms are parallel to the floor. Press back up by extending your elbows. The overhand grip and upright position maximize triceps activation while the machine assistance helps you complete more reps.',
  ),
  'lever_parallel_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Sit in a lever chest press machine with handles positioned parallel to each other (neutral grip). Press the handles forward until arms are fully extended. Squeeze your chest. Return with control. The parallel grip path provides a unique angle of chest activation and is extremely comfortable on the shoulders, allowing for heavy, safe pressing.',
  ),
  'lever_pec_deck_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.6,
    },
    description: 'HOW TO: Sit in a pec deck machine with back against the pad. Place your forearms against the pads or grip the handles. Bring the pads/handles together in front of your chest by contracting your chest. Squeeze hard at peak contraction. Return with control. The pec deck provides perfect chest isolation without involving triceps, building exceptional inner chest development.',
  ),
  'lever_pistol_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Stand on one leg in a lever squat machine with your other leg extended forward. Hold onto the handles for balance. Squat down on your single leg as deep as possible while keeping your extended leg off the ground. Drive through your heel to stand back up. The machine provides support and balance assistance while you build exceptional unilateral leg strength.',
  ),
  'lever_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a lever preacher curl machine with your upper arms resting on the pad. Grip the handles with palms up. Curl the handles up toward your shoulders by contracting your biceps. Squeeze hard at peak contraction. Lower with control to full extension. The preacher position locks your arms in place, eliminating momentum and providing perfect biceps isolation for maximum growth.',
  ),
  'lever_preacher_curl_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Position yourself at a plate-loaded preacher curl machine with arms on the pad. Grip the handles with palms facing up. Curl the handles up by contracting your biceps. Squeeze at the top. Lower with control. Plate-loaded machines provide smooth, natural resistance with the added benefit of micro-loading for progressive overload and consistent biceps growth.',
  ),
  'lever_preacher_curl_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'biceps': 0.0,
    },
    secondaryMuscles: {
      'forearms': 0.6,
    },
    description: 'HOW TO: Sit at a lever preacher curl machine with arms supported on the pad. Curl the levers up toward your shoulders. Squeeze your biceps intensely at the top. Lower with control. This variation may offer a different arm angle, handle position, or resistance curve compared to standard preacher curl machines, providing fresh stimulus for biceps development.',
  ),
  'lever_pullover_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'triceps': 0.6,
    },
    description: 'HOW TO: Sit at a plate-loaded pullover machine with the pad positioned across your upper chest. Grip the handles overhead. Pull the handles down in an arc toward your chest by contracting your lats. Squeeze your lats hard. Return with control. The machine provides a fixed path and constant tension, making it superior to dumbbell pullovers for lat isolation and rib cage expansion.',
  ),
  'lever_reverse_grip_preacher_curl': ExerciseMuscleData(
    primaryMuscles: {
      'brachialis': 0.0,
      'forearms': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
    },
    description: 'HOW TO: Sit at a lever preacher curl machine. Grip the handles with an overhand grip (palms facing down). Rest your arms on the pad. Curl the handles up toward your shoulders while maintaining the reverse grip. Squeeze at the top. Lower with control. The preacher position eliminates cheating while the reverse grip builds the brachialis and forearms for complete arm development.',
  ),
  'lever_reverse_grip_vertical_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Sit at a lever row machine. Grip the handles with an underhand grip (palms facing up). Pull the handles toward your lower chest by driving your elbows straight back and down. Keep your torso upright. Squeeze your lats and upper back. Return with control. The reverse grip increases biceps and lower lat involvement for complete back development.',
  ),
  'lever_reverse_t_bar_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Position yourself on a lever T-bar row machine with chest supported. Grip the handles with an underhand grip (palms up). Pull the handles toward your chest by driving your elbows back. Keep your elbows close to your body. Squeeze your lats. Return with control. The reverse grip emphasizes the lower lats and biceps for thick back development.',
  ),
  'lever_rotary_calf': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Position yourself in a rotary calf machine with pads on your shoulders or a seat supporting you. Place the balls of your feet on the platform with heels hanging off. Lower your heels to stretch your calves fully. Press up onto your toes as high as possible by contracting your calves. Squeeze maximally at the top. The rotary design provides a unique resistance curve for maximum calf activation.',
  ),
  'lever_row_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Sit at a plate-loaded row machine with chest against the pad. Grip the handles. Pull the handles toward your chest by driving your elbows straight back. Squeeze your shoulder blades together. Return with control. Plate-loaded rows provide natural, smooth resistance that feels similar to free weights while offering the stability and safety of a machine.',
  ),
  'lever_seated_calf_press': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever calf press machine with the pad across your thighs. Place the balls of your feet on the platform with heels hanging off. Lower your heels below the platform to stretch your calves. Press up onto your toes as high as possible. Squeeze hard at the top. The seated position with bent knees emphasizes the soleus (lower calf) for complete calf development.',
  ),
  'lever_seated_calf_raise_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a plate-loaded seated calf raise machine with the pad across your thighs. Place the balls of your feet on the platform with heels off the edge. Lower your heels to fully stretch your calves. Press up onto your toes as high as possible. Squeeze maximally. The seated bent-knee position targets the soleus muscle for building thickness in the lower calf.',
  ),
  'lever_seated_crunch': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever crunch machine with the pad positioned across your upper chest. Crunch forward by flexing your spine, bringing the pad down toward your hips. Contract your abs hard at the bottom. Return with control. The seated position and machine resistance provide constant tension throughout the movement, making it superior to floor crunches for building defined abs.',
  ),
  'lever_seated_crunch_chest_pad': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever crunch machine with a chest pad positioned across your upper torso. Grip the handles if available. Crunch forward by contracting your abs, bringing your chest down toward your pelvis. Squeeze your abs maximally. Return with control. The chest pad provides comfortable support while the machine ensures consistent resistance for building rock-solid abs.',
  ),
  'lever_seated_dip': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'front_delts': 0.6,
    },
    description: 'HOW TO: Sit in a lever-assisted dip machine. Grip the handles at your sides. Press down on the handles by extending your elbows until arms are straight. Keep your torso upright to emphasize triceps. Return with control. The seated position provides stability while the machine assistance allows you to perform more reps for building powerful triceps.',
  ),
  'lever_seated_fly': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.6,
    },
    description: 'HOW TO: Sit in a lever fly machine with back against the pad. Place your arms against the pads or grip the handles with arms extended. Bring the pads together in front of your chest by contracting your chest. Squeeze hard at peak contraction. Return with control. This machine isolates the chest perfectly without triceps involvement, building exceptional inner chest development.',
  ),
  'lever_seated_hip_abduction': ExerciseMuscleData(
    primaryMuscles: {
      'hip_abductors': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever hip abduction machine with the pads positioned on the outside of your thighs. Press your legs outward against the pads by contracting your hip abductors and glutes. Squeeze hard at maximum abduction. Return with control. This machine isolates the outer hip and glute muscles, building strength, stability, and aesthetic hip development.',
  ),
  'lever_seated_hip_abduction_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'hip_abductors': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a seated hip abduction machine with pads on the outside of your knees. Push your knees outward against the resistance by contracting your outer hips and glutes. Hold the peak contraction. Return with control. This variation may offer a different seat angle or pad position, but the movement remains focused on building strong, shapely hips and glutes.',
  ),
  'lever_seated_hip_adduction': ExerciseMuscleData(
    primaryMuscles: {
      'hip_adductors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever hip adduction machine with the pads positioned on the inside of your thighs. Press your legs together against the pads by contracting your inner thighs. Squeeze hard at peak contraction. Return with control. This machine isolates the inner thigh adductor muscles for leg development, hip stability, and injury prevention.',
  ),
  'lever_seated_hip_adduction_version_2': ExerciseMuscleData(
    primaryMuscles: {
      'hip_adductors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a seated hip adduction machine with pads on the inside of your knees. Squeeze your knees together by contracting your inner thigh muscles. Hold the squeeze at peak contraction. Return with control. Different machines may offer varying seat angles or resistance curves, but all effectively build the inner thigh adductors.',
  ),
  'lever_seated_leg_curl': ExerciseMuscleData(
    primaryMuscles: {
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'calves': 0.6,
    },
    description: 'HOW TO: Sit in a lever leg curl machine with back against the pad. Position your lower legs on top of the padded lever arm. Curl your feet down toward your glutes by contracting your hamstrings. Squeeze hard at peak contraction. Return with control. The seated position provides a different angle than lying leg curls, hitting the hamstrings from a unique position for complete development.',
  ),
  'lever_seated_leg_press': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'calves': 0.6,
    },
    description: 'HOW TO: Sit in a lever leg press machine with back against the pad. Place feet shoulder-width apart on the platform. Release the safety and press the platform away by extending your knees and hips. Go to just short of locking out. Lower with control until knees are at 90 degrees or slightly deeper. Leg presses allow for heavy loading with reduced spinal stress.',
  ),
  'lever_seated_one_leg_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a seated calf raise machine. Place one foot on the platform with heel hanging off. Position the pad across your thigh. Lower your heel to fully stretch your calf. Press up onto your toes as high as possible. Squeeze hard at the top. Complete all reps, then switch legs. The unilateral approach addresses strength imbalances and builds symmetrical calf development.',
  ),
  'lever_seated_reverse_fly': ExerciseMuscleData(
    primaryMuscles: {
      'rear_delts': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.5,
    },
    description: 'HOW TO: Sit facing the pad of a lever reverse fly machine with chest against it. Grip the handles with arms extended in front. Pull the handles back and out to your sides in a reverse fly motion. Focus on squeezing your rear delts and shoulder blades together. Return with control. This machine provides perfect rear delt isolation for complete shoulder development and improved posture.',
  ),
  'lever_seated_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Sit at a lever row machine with chest against the pad. Grip the handles. Pull the handles toward your chest by driving your elbows straight back. Squeeze your shoulder blades together. Return with control. The machine provides a fixed path and constant tension, making it excellent for building back thickness without worrying about form breakdown.',
  ),
  'lever_seated_shoulder_press': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit in a lever shoulder press machine with back supported. Grip the handles at shoulder height. Press the handles straight up overhead until arms are fully extended. Lower with control. The machine provides a guided path and stability, allowing you to safely train to failure and build massive shoulders without needing a spotter.',
  ),
  'lever_seated_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Sit in a lever squat machine with back against the pad and shoulders under the supports. Place feet on the platform. Release the safety. Lower down by bending your knees as if sitting deeper into a chair. Go at least to parallel. Drive through your heels to press back up. The machine guides the movement, making it safer than free squats while still building powerful legs.',
  ),
  'lever_seated_twist': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit in a lever twist machine with the pad positioned across your chest. Grip the handles. Rotate your torso to one side as far as comfortable by contracting your obliques. Return to center, then rotate to the other side. The machine provides resistance throughout the rotational movement, building powerful obliques and rotational core strength for sports and functional movements.',
  ),
  'lever_seated_wide_squat': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
      'hip_adductors': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
    },
    description: 'HOW TO: Sit in a lever squat machine with feet positioned wider than shoulder-width and toes pointed out. Lower down by bending your knees, allowing them to track over your toes. Go deep. Drive through your heels to press back up. The wide stance emphasizes the inner thighs, glutes, and adductors more than standard squats for complete lower body development.',
  ),
  'lever_shoulder_press_plate_loaded_ii': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Sit in a plate-loaded shoulder press machine with back supported. Grip the handles at shoulder level. Press straight up overhead until arms are fully extended. Lower with control. Plate-loaded machines provide smooth, natural resistance similar to free weights while offering the stability to train safely to failure for maximum shoulder growth.',
  ),
  'lever_shoulder_press_plate_loaded_version_3': ExerciseMuscleData(
    primaryMuscles: {
      'shoulders': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position yourself in a plate-loaded shoulder press machine. Press the handles overhead until arms are extended. Lower with control. This variation may offer a different seat angle, handle position, or pressing path compared to other machines, providing variety in your shoulder training while maintaining the benefits of machine stability.',
  ),
  'lever_shrug_bench_press_machine': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Position yourself in a bench press machine modified for shrugs. Grip the handles or position shoulder pads on your shoulders. Shrug straight up toward your ears by contracting your traps. Hold at the top. Lower with control. The machine provides a fixed path and allows for heavy loading, building massive trap development.',
  ),
  'lever_shrug_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'traps': 0.0,
    },
    secondaryMuscles: {
      'upper_back': 0.6,
    },
    description: 'HOW TO: Stand in a plate-loaded shrug machine with handles at your sides or shoulder pads on your shoulders. Shrug straight up by contracting your traps. Hold the peak contraction. Lower with control. Don\'t roll your shoulders. Plate-loaded shrug machines allow for progressive overload and build impressive trap development without grip fatigue limiting your set.',
  ),
  'lever_side_hip_abduction': ExerciseMuscleData(
    primaryMuscles: {
      'hip_abductors': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand on one leg in a lever hip abduction machine with the pad positioned on the outside of your working leg. Push your leg out to the side by contracting your hip abductors and glutes. Keep your torso upright. Return with control. Complete all reps, then switch sides. This standing version adds a balance challenge while building strong, aesthetic hips.',
  ),
  'lever_side_hip_adduction': ExerciseMuscleData(
    primaryMuscles: {
      'hip_adductors': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand on one leg in a lever hip adduction machine with the pad on the inside of your free leg. Pull your free leg across your body by contracting your inner thigh. Keep your torso upright and stable. Return with control. Complete all reps, then switch sides. The standing position challenges balance while isolating the inner thigh adductors.',
  ),
  'lever_single_arm_neutral_grip_seated_row_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Sit at a plate-loaded row machine with chest against the pad. Grip one handle with a neutral grip (palm facing in). Pull the handle toward your chest by driving your elbow straight back. Squeeze your lat and upper back. Return with control. Complete all reps, then switch arms. Unilateral training ensures balanced back development and addresses strength imbalances.',
  ),
  'lever_squat_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'quads': 0.0,
      'glutes': 0.0,
    },
    secondaryMuscles: {
      'hamstrings': 0.5,
      'core': 0.6,
    },
    description: 'HOW TO: Position yourself in a plate-loaded squat machine with shoulders under the pads and feet on the platform. Release the safety. Squat down by bending your knees until thighs are at least parallel to the platform. Drive through your heels to press back up. Plate-loaded squats provide smooth resistance while the machine guides the movement for safe, heavy leg training.',
  ),
  'lever_standing_calf_raise': ExerciseMuscleData(
    primaryMuscles: {
      'calves': 0.0,
    },
    secondaryMuscles: {
      'core': 0.6,
    },
    description: 'HOW TO: Stand in a lever calf raise machine with shoulder pads on your shoulders. Place the balls of your feet on the platform with heels hanging off. Lower your heels below the platform to stretch your calves fully. Press up onto your toes as high as possible. Squeeze hard at the top. Standing calf raises build the gastrocnemius (upper calf) for explosive power and aesthetic development.',
  ),
  'lever_standing_hip_extension': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
      'core': 0.6,
    },
    description: 'HOW TO: Stand facing a lever hip extension machine. Position the pad behind one leg. Kick your leg straight back by contracting your glutes and hamstrings. Keep your torso upright and core tight. Squeeze your glutes at full extension. Return with control. Complete all reps, then switch legs. This machine isolates the glutes and hamstrings for powerful posterior chain development.',
  ),
  'lever_standing_leg_raise': ExerciseMuscleData(
    primaryMuscles: {
      'hip_flexors': 0.0,
      'core': 0.0,
    },
    secondaryMuscles: {
      'quads': 0.6,
    },
    description: 'HOW TO: Stand in a lever leg raise machine with back against the pad. Hook one leg under or on the lever arm. Raise your leg up in front of you by contracting your hip flexors and lower abs. Keep your leg relatively straight. Lower with control. Complete all reps, then switch legs. This machine provides resistance for building strong hip flexors and lower abs.',
  ),
  'lever_standing_rear_kick': ExerciseMuscleData(
    primaryMuscles: {
      'glutes': 0.0,
      'hamstrings': 0.0,
    },
    secondaryMuscles: {
      'lower_back': 0.6,
    },
    description: 'HOW TO: Stand facing a machine with the pad positioned behind one leg. Kick your leg straight back and up by contracting your glutes and hamstrings. Keep your torso stable and don\'t arch your lower back excessively. Squeeze your glutes hard at the top. Return with control. This isolation exercise builds powerful, shapely glutes.',
  ),
  'lever_t_bar_reverse_grip_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.6,
    },
    description: 'HOW TO: Straddle a lever T-bar row machine with chest supported if available. Grip the handles with an underhand grip (palms facing up). Pull the handles toward your lower chest by driving your elbows back and keeping them close to your body. Squeeze your lats. The reverse grip increases biceps and lower lat involvement for complete back thickness.',
  ),
  'lever_t_bar_row_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
      'lower_back': 0.6,
    },
    description: 'HOW TO: Straddle a plate-loaded T-bar row with feet on the platform. Bend forward at the hips with a flat back. Grip the handles. Pull the handles toward your chest by driving your elbows back. Squeeze your lats and upper back together. Lower with control. T-bar rows are legendary for building thick, powerful lats and a wide back.',
  ),
  'lever_triceps_dip_plate_loaded': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {
      'chest': 0.5,
      'front_delts': 0.6,
    },
    description: 'HOW TO: Position yourself in a plate-loaded assisted dip machine. Grip the handles and support yourself. Lower your body by bending your elbows until upper arms are parallel to the floor. Press back up by extending your elbows. Keep your torso upright for triceps emphasis. The assisted machine allows you to complete more reps for building powerful triceps.',
  ),
  'lever_triceps_extension': ExerciseMuscleData(
    primaryMuscles: {
      'triceps': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Sit or stand at a lever triceps extension machine. Position your elbows on the pad with upper arms stationary. Grip the handles. Extend your forearms by straightening your elbows. Squeeze your triceps at full extension. Return with control. The machine provides a fixed path and constant tension, making it superior to free weights for triceps isolation.',
  ),
  'lever_unilateral_row': ExerciseMuscleData(
    primaryMuscles: {
      'lats': 0.0,
      'upper_back': 0.0,
    },
    secondaryMuscles: {
      'biceps': 0.5,
      'rear_delts': 0.5,
    },
    description: 'HOW TO: Sit at a lever row machine with chest against the pad. Grip one handle. Pull the handle toward your chest by driving your elbow straight back. Squeeze your lat and upper back. Return with control. Complete all reps, then switch arms. Unilateral rows ensure balanced back development, prevent compensation patterns, and address strength imbalances.',
  ),
  'leverage_incline_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'front_delts': 0.5,
      'triceps': 0.5,
    },
    description: 'HOW TO: Sit in a leverage incline chest press machine with back against the angled pad. Grip the handles at upper chest level. Press the handles up and forward until arms are fully extended. Squeeze your upper chest. Return with control. Leverage machines provide smooth, natural resistance with a fixed path, making them excellent for building the upper chest safely.',
  ),
  'lying_leg_raise_and_hold': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie flat on your back with hands under your glutes. Lift your legs up until they\'re perpendicular to the floor, keeping them straight. Hold this top position for time. Your lower back should stay pressed to the floor. Lower with control when the hold time is complete. This isometric hold builds exceptional core endurance and lower ab strength.',
  ),
  'lying_leg_raise_flat_bench': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
      'hip_flexors': 0.0,
    },
    secondaryMuscles: {},
    description: 'HOW TO: Lie on a flat bench with legs extended off one end. Grab the bench above your head for support. Keep your legs straight and together. Lift your legs up by contracting your lower abs until they\'re perpendicular to your body. Lower with control without letting them touch the bench. The elevation increases the range of motion for advanced ab development.',
  ),
  'machine_inner_chest_press': ExerciseMuscleData(
    primaryMuscles: {
      'chest': 0.0,
    },
    secondaryMuscles: {
      'triceps': 0.5,
      'front_delts': 0.5,
    },
    description: 'HOW TO: Sit in an inner chest press machine designed with a narrow, converging press path. Grip the handles close together. Press forward until arms are extended, bringing the handles together in front of your chest. Squeeze your inner chest hard. Return with control. This specialized machine emphasizes the inner pec fibers for complete chest development.',
  ),
  'pull_in_on_stability_ball': ExerciseMuscleData(
    primaryMuscles: {
      'core': 0.0,
    },
    secondaryMuscles: {
      'hip_flexors': 0.6,
      'shoulders': 0.6,
    },
    description: 'HOW TO: Start in a plank position with shins on a stability ball and hands on the floor. Keep your body straight. Pull your knees toward your chest by contracting your abs, rolling the ball forward. Pause with knees tucked. Extend your legs back out to plank. The instability of the ball engages deep core stabilizers while building powerful abs.',
  ),
};
