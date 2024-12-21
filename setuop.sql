-- SET ROLE CONTEXT
USE ROLE accountadmin;

-- SET DABATASE SCHEMA CONTEXT
USE SCHEMA sila_demo_db.notebooks;

-- SET WAREHOUSE CONTEXT
USE WAREHOUSE sila_demo_wh;

-- CREATE COMPUTE POOL
CREATE COMPUTE POOL IF NOT EXISTS cpu_xs_5_nodes
    MIN_NODES = 1
    MAX_NODES = 5
    INSTANCE_FAMILY = CPU_X64_XS;

-- CREATE NETWORK RULE
CREATE NETWORK RULE allow_all_rule
    TYPE = 'HOST_PORT'
    MODE= 'EGRESS'
    VALUE_LIST = ('0.0.0.0:443','0.0.0.0:80');

-- CREATE EXTERNAL ACCESS INTEGRATION
CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION allow_all_integration
    ALLOWED_NETWORK_RULES = (allow_all_rule)
    ENABLED = true;

-- CREATE NETWORK RULE
CREATE OR REPLACE NETWORK RULE pypi_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('pypi.org', 'pypi.python.org', 'pythonhosted.org',  'files.pythonhosted.org');

-- CREATE EXTERNAL ACCESS INTEGRATION
CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION pypi_access_integration
  ALLOWED_NETWORK_RULES = (pypi_network_rule)
  ENABLED = true;

GRANT ALL ON WAREHOUSE sila_demo_wh TO ROLE sysadmin;
GRANT USAGE ON COMPUTE POOL cpu_xs_5_nodes TO ROLE sysadmin;
GRANT USAGE ON COMPUTE POOL gpu_s_5_nodes TO ROLE sysadmin;
GRANT USAGE ON DATABASE sila_demo_db TO ROLE sysadmin;
GRANT ALL ON SCHEMA sila_demo_db.notebooks TO ROLE sysadmin;
GRANT CREATE STAGE ON SCHEMA sila_demo_db.notebooks TO ROLE sysadmin;
GRANT CREATE NOTEBOOK ON SCHEMA sila_demo_db.notebooks TO ROLE sysadmin;
GRANT CREATE SERVICE ON SCHEMA sila_demo_db.notebooks TO ROLE sysadmin;
GRANT USAGE ON INTEGRATION allow_all_integration TO ROLE sysadmin;
GRANT USAGE ON INTEGRATION pypi_access_integration TO ROLE sysadmin;