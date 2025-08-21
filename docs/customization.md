# Customization Guide

## Modifying Intent Classification

- Update the Intent Classifier prompt to add or refine categories
- Adjust confidence thresholds to influence routing sensitivity

## Adding New Agent Types

1. Create a new prompt/component in Langflow
2. Connect an OpenAI model to it
3. Update the Enhanced Router to include the new branch
4. Test routing behavior with representative prompts

## Router Configuration

- Tune `INTENT_CONFIDENCE_THRESHOLD`
- Enable/disable context validation
- Define fallback messages for ambiguous inputs

## Tips

- Keep temperatures low for deterministic behavior
- Store reusable examples for component generation in a dedicated repo
