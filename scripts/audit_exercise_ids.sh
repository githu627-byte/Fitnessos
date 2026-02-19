#!/bin/bash
# audit_exercise_ids.sh
# Checks that every exercise ID used in workout_data.dart presets
# exists as a key in movement_engine.dart's exercises map.
#
# Usage: bash scripts/audit_exercise_ids.sh

set -e

ENGINE_FILE="lib/core/patterns/movement_engine.dart"
DATA_FILE="lib/models/workout_data.dart"

# Extract all engine keys (the single-quoted keys in the exercises map)
ENGINE_IDS=$(grep -oP "^\s+'([a-z_0-9]+)'\s*:" "$ENGINE_FILE" | sed "s/^[[:space:]]*'//;s/'[[:space:]]*://" | sort -u)
ENGINE_COUNT=$(echo "$ENGINE_IDS" | wc -l)

# Extract all exercise IDs from uncommented lines in workout_data.dart
# Filter out non-exercise IDs (workout/category/circuit/split IDs)
ALL_IDS=$(grep "id:" "$DATA_FILE" | grep -v "^[[:space:]]*//" | grep -o "id: '[a-z_0-9]*'" | sed "s/id: '//;s/'//" | sort -u)
EXERCISE_IDS=$(echo "$ALL_IDS" | grep -v -E "^(arms_arsenal|at_home|cardio|cardio_blast|circuits|core_destroyer|endurance_builder|full_body|full_body_hiit|gym_|home_|leg_burner|ppl|splits|training_splits|upper_blast|upper_lower)")
EXERCISE_COUNT=$(echo "$EXERCISE_IDS" | wc -l)

# Find broken IDs
BROKEN=$(comm -23 <(echo "$EXERCISE_IDS") <(echo "$ENGINE_IDS"))

echo "==========================================="
echo "EXERCISE ID AUDIT RESULTS"
echo "==========================================="
echo "Movement engine keys: $ENGINE_COUNT"
echo "Unique exercise IDs in presets: $EXERCISE_COUNT"
echo ""

if [ -z "$BROKEN" ]; then
  echo "ALL PRESET IDS FOUND IN MOVEMENT ENGINE"
  echo ""
  echo "No broken exercise IDs detected."
  exit 0
else
  BROKEN_COUNT=$(echo "$BROKEN" | wc -l)
  echo "BROKEN IDS - IN PRESETS BUT NOT IN MOVEMENT ENGINE:"
  echo ""
  echo "$BROKEN" | while read -r id; do
    echo "  $id"
    grep "id: '$id'" "$DATA_FILE" | grep -v "^[[:space:]]*//" | head -3 | while read -r line; do
      echo "    -> $(echo "$line" | sed 's/^[[:space:]]*//')"
    done
    echo ""
  done
  echo "TOTAL BROKEN: $BROKEN_COUNT exercise IDs"
  echo ""
  echo "==========================================="
  echo "WHAT TO FIX:"
  echo "==========================================="
  echo "For each broken ID, EITHER:"
  echo "  A) Add the ID to movement_engine.dart with correct pattern config"
  echo "  B) Change the preset ID to one that exists in movement_engine"
  echo ""
  echo "DO NOT change movement_engine IDs that already work."
  echo "DO NOT delete working configs."
  exit 1
fi
