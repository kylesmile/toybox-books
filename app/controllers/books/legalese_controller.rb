# frozen_string_literal: true

module Books
  class LegaleseController < ApplicationController
    allow_unauthenticated_access

    def terms_of_use
    end

    def privacy_policy
    end
  end
end
