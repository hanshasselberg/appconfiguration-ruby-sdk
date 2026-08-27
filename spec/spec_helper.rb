# frozen_string_literal: true

# Copyright 2026 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "ibm_appconfiguration_ruby_sdk"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Keep the SDK logger quiet during the test run.
  real_log = nil

  config.before(:suite) do
    logger = IbmAppconfigurationRubySdk::Logger.instance
    logger.debug = false
    real_log = logger.instance_variable_get(:@log)
    # Redirect the underlying ::Logger to /dev/null so error/info messages
    # (which are always emitted) don't pollute the spec output.
    logger.instance_variable_set(:@log, ::Logger.new(File::NULL))
  end

  config.after(:suite) do
    IbmAppconfigurationRubySdk::Logger.instance.instance_variable_set(:@log, real_log)
  end
end
