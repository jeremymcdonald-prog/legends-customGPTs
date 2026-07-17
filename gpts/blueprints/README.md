# Authorized GPT blueprints

Place an approved `<slug>.yaml` blueprint here only when an individual GPT build is authorized. Start from `core/templates/gpt_blueprint.template.yaml` and do not copy core modules into a blueprint.

`scripts/rebuild_all_gpts.rb` validates and regenerates every registered blueprint so one shared profile or core-module update propagates across the portfolio. This directory intentionally contains no GPT blueprint during the Factory refactor.
