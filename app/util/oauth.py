# # Set up OAuth
# from fastapi.security import OAuth2AuthorizationCodeBearer, OAuth2PasswordBearer, OAuth2
# from app.core.config import configs
# from starlette.config import Config
# from authlib.integrations.starlette_client import OAuth



# config_data = {'GOOGLE_CLIENT_ID': configs.GOOGLE_CLIENT_ID, 'GOOGLE_CLIENT_SECRET': configs.GOOGLE_CLIENT_SECRET}
# starlette_config = Config(environ=config_data)
# oauth = OAuth()

# oauth.register(
#     name='google',
#     client_id=configs.GOOGLE_CLIENT_ID,
#     client_secret=configs.GOOGLE_CLIENT_SECRET,
#     server_metadata_url='https://accounts.google.com/.well-known/openid-configuration',
#     client_kwargs={'scope': 'openid email profile'},
# )

# # oauth2 Schema
# oauth2_password_scheme = OAuth2PasswordBearer(tokenUrl="login")
# google_oauth2_scheme = OAuth2AuthorizationCodeBearer(
#     authorizationUrl="https://accounts.google.com/o/oauth2/auth",
#     tokenUrl="https://oauth2.googleapis.com/token"
# )